import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import '../models/ai_score_model.dart';

@lazySingleton
class AiRemoteDataSource {
  late final GenerativeModel _model;

  AiRemoteDataSource() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: _getJsonSchema(),
      ),
    );
  }

  Schema _getJsonSchema() {
    return Schema.object(
      properties: {
        'score': Schema.integer(description: 'Matching score (0-100)'),
        'summary': Schema.string(description: 'Candidate fit summary'),
        'pros': Schema.array(
          items: Schema.string(description: 'A key strength of the candidate'),
        ),
        'cons': Schema.array(
          items: Schema.string(
            description: 'A key weakness or missing requirement',
          ),
        ),
      },
    );
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

CRITICAL INSTRUCTION: Generate ONLY a JSON object that strictly adheres to the provided schema. Do not include any pre-amble, explanation, or markdown formatting.
''';

    final response = await _model.generateContent([Content.text(prompt)]);
    final responseText = response.text;

    if (responseText == null || responseText.isEmpty) {
      throw Exception('AI returned empty or null response text.');
    }

    final jsonMap = await compute(_decodeJson, responseText);
    return AiScoreModel.fromJson(jsonMap);
  }
}

Map<String, dynamic> _decodeJson(String text) {
  return jsonDecode(text) as Map<String, dynamic>;
}
