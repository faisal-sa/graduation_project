import 'dart:convert';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import '../models/ai_score_model.dart';


@lazySingleton
class AiRemoteDataSource {
  final GeminiService _geminiService;

  AiRemoteDataSource(this._geminiService);

  Map<String, dynamic> _getJsonSchema() {
    return {
      "type": "OBJECT",
      "properties": {
        "score": {"type": "INTEGER", "description": "Matching score (0-100)"},
        "summary": {"type": "STRING", "description": "Candidate fit summary"},
        "pros": {
          "type": "ARRAY",
          "items": {"type": "STRING", "description": "A key strength of the candidate"}
        },
        "cons": {
          "type": "ARRAY",
          "items": {"type": "STRING", "description": "A key weakness or missing requirement"}
        }
      },
      "required": ["score", "summary", "pros", "cons"]
    };
  }

  Future<AiScoreModel> analyzeCandidate({
    required Map<String, dynamic> candidateData,
    required Map<String, dynamic> jobRequirements,
  }) async {
    final candidateStr = json.encode(candidateData);
    final jobStr = json.encode(jobRequirements);

    final prompt =
        '''
You are an expert HR Recruiter AI.
Analyze the candidate against the job requirements. Your analysis must be solely based on the provided JSON data.

**Job Requirements JSON:**
$jobStr

**Candidate Data JSON:**
$candidateStr

CRITICAL INSTRUCTION: Generate ONLY a JSON object that strictly adheres to the provided schema.
''';

    final responseText = await _geminiService.generateContent(
      prompt: prompt,
      model: 'gemini-2.5-flash-lite',
      jsonSchema: _getJsonSchema(),
      enforceJson: true,
    );

    if (responseText == null || responseText.isEmpty) {
      throw Exception('AI returned empty or null response text.');
    }

    final jsonMap = await compute(_decodeJson, responseText);
    return AiScoreModel.fromJson(jsonMap);
  }
}

Map<String, dynamic> _decodeJson(String text) {
  String cleanText = text.replaceAll(RegExp(r'```json|```'), '').trim();
  return jsonDecode(cleanText) as Map<String, dynamic>;
}