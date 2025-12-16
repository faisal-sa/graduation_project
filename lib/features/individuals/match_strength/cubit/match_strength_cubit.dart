
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:graduation_project/features/individuals/match_strength/cubit/match_strength_state.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';



@injectable
class MatchStrengthCubit extends Cubit<MatchStrengthState> {
  final GeminiService _geminiService;

  MatchStrengthCubit({required GeminiService geminiService})
      : _geminiService = geminiService,
        super(MatchStrengthInitial());

  Future<void> analyzeProfile(UserEntity userEntity) async {
    emit(MatchStrengthLoading());

    try {
      final jobTitle = userEntity.jobTitle.isNotEmpty ? userEntity.jobTitle : "General Role";

      final experienceString = userEntity.workExperiences.isNotEmpty
          ? userEntity.workExperiences
              .map((e) => "Role: ${e.jobTitle} at ${e.companyName}. Description: ${e.responsibilities.join(', ')}")
              .join("\n")
          : "No specific work experience listed.";

      final educationString = userEntity.educations.isNotEmpty
          ? userEntity.educations
              .map((e) => "Degree: ${e.fieldOfStudy} at ${e.institutionName}")
              .join("\n")
          : "No formal education listed.";

      final skillsString = userEntity.skills.isNotEmpty
          ? userEntity.skills.join(", ")
          : "No specific skills listed.";

      final certString = userEntity.certifications.isNotEmpty
          ? userEntity.certifications
              .map((c) => "${c.name} from ${c.issuingInstitution}")
              .join("\n")
          : "No certifications.";

      final prompt = '''
        Act as an expert ATS (Applicant Tracking System) AI. 
        Analyze this candidate for the target role: "$jobTitle".
        
        CANDIDATE DATA:
        Summary: ${userEntity.summary}
        Skills: $skillsString
        Experience: $experienceString
        Education: $educationString
        Certifications: $certString
        
        TASK:
        Compare the candidate's data against standard industry requirements for a "$jobTitle".
        
        Return valid JSON ONLY. No markdown, no explanations.
        {
          "score": (integer 0-100 based on keyword match and experience relevance),
          "strengths": ["List of 3 distinct, short key selling points"],
          "improvements": [
            {
              "issue": "Specific missing hard skill or gap (Max 6 words)",
              "action": "Specific 3-5 word recommendation (e.g. 'Learn SQL', 'Get PMP Cert')"
            }
          ]
        }
      ''';

      // Call Dio Service
      final responseText = await _geminiService.generateContent(
        prompt: prompt,
        model: 'gemini-2.5-flash',
        // We enforce JSON MIME type to help the model, even without a strict schema object here
        enforceJson: true, 
      );
      
      if (responseText == null) {
        emit(const MatchStrengthError("Could not generate analysis."));
        return;
      }

      final cleanedJson = responseText
          .replaceAll(RegExp(r'```json|```'), '')
          .trim();

      final startIndex = cleanedJson.indexOf('{');
      final endIndex = cleanedJson.lastIndexOf('}');

      if (startIndex == -1 || endIndex == -1) {
        throw FormatException("Invalid JSON format received");
      }

      final jsonString = cleanedJson.substring(startIndex, endIndex + 1);
      final data = jsonDecode(jsonString);

      emit(MatchStrengthLoaded(
        score: (data['score'] as num).toInt(),
        strengths: List<String>.from(data['strengths'] ?? []),
        improvements: List<Map<String, String>>.from(
          (data['improvements'] as List).map((item) => {
            'issue': item['issue'].toString(),
            'action': item['action'].toString(),
          })
        ),
      ));

    } catch (e) {
      emit(MatchStrengthError("Analysis failed: ${e.toString()}"));
    }
  }
}