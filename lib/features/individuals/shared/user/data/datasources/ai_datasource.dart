import 'dart:convert';
import 'dart:typed_data';

import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';


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
      You are a data extraction assistant.
      Analyze the attached resume PDF.
      Extract the following fields and return them in a raw JSON format:
      - firstName
      - lastName
      - email
      - phoneNumber
      - summary (Create a short professional summary if one doesn't exist)

      Rules:
      1. Return ONLY the JSON object. Do not include markdown formatting like ```json ... ```.
      2. If a field is not found, use an empty string "".
      3. Fix any capitalization issues in names.
    """;

    final responseText = await _geminiService.generateContent(
      prompt: promptText,
      binaryData: pdfBytes,
      mimeType: 'application/pdf',
      model: 'gemini-2.5-flash-lite',
    );

    debugPrint("AI response to Resume upload:\n $responseText");
    
    if (responseText == null || responseText.isEmpty) {
      throw Exception("AI returned empty response");
    }

    try {
      // Clean up markdown formatting if Gemini adds it
      String cleanJson = responseText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final Map<String, dynamic> data = jsonDecode(cleanJson);

      return UserEntity(
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        summary: data['summary'] ?? '',
      );
    } catch (e) {
      debugPrint("JSON Parse Error: $e");
      throw Exception("Failed to parse AI JSON: $e");
    }
  }
}