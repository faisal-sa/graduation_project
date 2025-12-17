import 'dart:convert';
import 'dart:typed_data';

import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/profile/routes/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/profile/routes/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';


abstract class AIDataSource {
  Future<UserEntity> extractResume(Uint8List pdfBytes);
}
@LazySingleton(as: AIDataSource)
class AIDataSourceImpl implements AIDataSource {
  final GeminiService _geminiService;

  AIDataSourceImpl(this._geminiService);

  @override
  Future<UserEntity> extractResume(Uint8List pdfBytes) async {
    const promptText = """
      You are a specialized Resume Parser. 
      Analyze the attached PDF and extract data into the specific JSON format defined below.
      
      Rules:
      1. Return ONLY raw JSON. No markdown (```json).
      2. Dates must be in "YYYY-MM-DD" format. If currently working/studying, leave end_date as null.
      3. If a field is missing, use empty string "" or empty list [].
      4. Fix capitalization for names and titles.
      
      JSON Schema:
      {
        "firstName": "String",
        "lastName": "String",
        "email": "String",
        "phoneNumber": "String",
        "location": "String (City, Country)",
        "jobTitle": "String (Current or most recent role)",
        "summary": "String (Professional summary. Generate one if missing)",
        "skills": ["String", "String"],
        "languages": ["String"],
        "workExperiences": [
          {
            "jobTitle": "String",
            "companyName": "String",
            "startDate": "YYYY-MM-DD",
            "endDate": "YYYY-MM-DD or null",
            "location": "String",
            "description": ["String (Bullet point 1)", "String (Bullet point 2)"]
          }
        ],
        "educations": [
          {
            "institutionName": "String",
            "degreeType": "String (e.g. BSc, MSc)",
            "fieldOfStudy": "String",
            "startDate": "YYYY-MM-DD",
            "endDate": "YYYY-MM-DD or null"
          }
        ],
        "certifications": [
          {
            "name": "String",
            "issuingInstitution": "String",
            "issueDate": "YYYY-MM-DD"
          }
        ]
      }
    """;

    final responseText = await _geminiService.generateContent(
      prompt: promptText,
      binaryData: pdfBytes,
      mimeType: 'application/pdf',
      model: 'gemini-2.5-flash-lite', 
    );

    if (responseText == null || responseText.isEmpty) {
      throw Exception("AI returned empty response");
    }

    try {
      String cleanJson = responseText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final Map<String, dynamic> data = jsonDecode(cleanJson);
      const uuid = Uuid();

      DateTime parseDate(String? dateStr) {
        if (dateStr == null || dateStr.isEmpty) return DateTime.now();
        try {
          return DateTime.parse(dateStr);
        } catch (_) {
          return DateTime.now(); 
        }
      }
      
      DateTime? parseNullableDate(String? dateStr) {
        if (dateStr == null || dateStr.isEmpty || dateStr.toLowerCase() == 'present') return null;
        try {
          return DateTime.parse(dateStr);
        } catch (_) {
          return null;
        }
      }

      return UserEntity(
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        location: data['location'] ?? '',
        jobTitle: data['jobTitle'] ?? '',
        summary: data['summary'] ?? '',
        skills: List<String>.from(data['skills'] ?? []),
        languages: List<String>.from(data['languages'] ?? []),
        
        workExperiences: (data['workExperiences'] as List? ?? []).map((e) {
          return WorkExperience(
            id: uuid.v4(), 
            jobTitle: e['jobTitle'] ?? '',
            companyName: e['companyName'] ?? '',
            location: e['location'] ?? '',
            startDate: parseDate(e['startDate']),
            endDate: parseNullableDate(e['endDate']),
            isCurrentlyWorking: e['endDate'] == null,
            responsibilities: List<String>.from(e['description'] ?? []),
          );
        }).toList(),

        educations: (data['educations'] as List? ?? []).map((e) {
          return Education(
            id: uuid.v4(),
            institutionName: e['institutionName'] ?? '',
            degreeType: e['degreeType'] ?? '',
            fieldOfStudy: e['fieldOfStudy'] ?? '',
            startDate: parseDate(e['startDate']),
            endDate: parseDate(e['endDate']), 
          );
        }).toList(),

        certifications: (data['certifications'] as List? ?? []).map((e) {
          return Certification(
            id: uuid.v4(),
            name: e['name'] ?? '',
            issuingInstitution: e['issuingInstitution'] ?? '',
            issueDate: parseDate(e['issueDate']),
          );
        }).toList(),
      );

    } catch (e) {
      debugPrint("Resume Parsing Error: $e");
      throw Exception("Failed to parse resume data: $e");
    }
  }
}