import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  final Dio _dio;
  // In a real app, use EnvConfig.geminiApiKey
  final String _apiKey = 'AIzaSyBLgMkD__ahfJ_kmwlCnF_0sPChmRY9iZg'; 
  final String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models';

  GeminiService(this._dio);

  Future<String?> generateContent({
    required String prompt,
    String model = 'gemini-2.5-flash-lite',
    Uint8List? binaryData,
    String? mimeType,
    Map<String, dynamic>? jsonSchema,
    bool enforceJson = false,
  }) async {
    final url = '$_baseUrl/$model:generateContent';

    // Build the parts list
    final List<Map<String, dynamic>> parts = [];

    // Add Binary Data (PDF/Image) if present
    if (binaryData != null && mimeType != null) {
      parts.add({
        "inline_data": {
          "mime_type": mimeType,
          "data": base64Encode(binaryData),
        }
      });
    }

    // Add Text Prompt
    parts.add({"text": prompt});

    // Construct Request Body
    final Map<String, dynamic> body = {
      "contents": [
        {
          "parts": parts,
        }
      ]
    };

    // Add Generation Config (for JSON mode)
    if (enforceJson || jsonSchema != null) {
      body["generationConfig"] = {
        "response_mime_type": "application/json",
        if (jsonSchema != null) "response_schema": jsonSchema,
      };
    }

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'x-goog-api-key': _apiKey,
            'Content-Type': 'application/json',
          },
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Parse the nested response structure
        // candidates -> [0] -> content -> parts -> [0] -> text
        if (data['candidates'] != null &&
            (data['candidates'] as List).isNotEmpty) {
          final candidate = data['candidates'][0];
          if (candidate['content'] != null &&
              candidate['content']['parts'] != null) {
            final parts = candidate['content']['parts'] as List;
            if (parts.isNotEmpty) {
              return parts[0]['text'] as String?;
            }
          }
        }
        return null;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Gemini API Error: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      debugPrint("Gemini Dio Error: ${e.response?.data}");
      rethrow;
    } catch (e) {
      debugPrint("Gemini Generic Error: $e");
      rethrow;
    }
  }
}
