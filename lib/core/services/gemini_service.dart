import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project/core/env_config/env_config.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  final Dio _dio;
    String get _apiKey => EnvConfig.geminiApiKey;

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

    final List<Map<String, dynamic>> parts = [];

    if (binaryData != null && mimeType != null) {
      parts.add({
        "inline_data": {
          "mime_type": mimeType,
          "data": base64Encode(binaryData),
        }
      });
    }

    parts.add({"text": prompt});

    final Map<String, dynamic> body = {
      "contents": [
        {
          "parts": parts,
        }
      ]
    };

    if (enforceJson || jsonSchema != null) {
      body["generationConfig"] = {
        "response_mime_type": "application/json",
        if (jsonSchema != null) "response_schema": jsonSchema,
      };
    }
    const int maxRetries = 1;
    int retryDelay = 10000; 

    for (int attempt = 0; attempt <= maxRetries; attempt++) {
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
            type: DioExceptionType.badResponse,
          );
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 503 || e.response?.statusCode == 429) {
          if (attempt < maxRetries) {
            debugPrint("Gemini Overloaded (503). Retrying in ${retryDelay}ms... (Attempt ${attempt + 1})");
            
            await Future.delayed(Duration(milliseconds: retryDelay));
            
            retryDelay *= 2; 
            continue; 
          }
        }
        
        debugPrint("Gemini Dio Error: ${e.response?.data}");
        rethrow;
      } catch (e) {
        debugPrint("Gemini Generic Error: $e");
        rethrow;
      }
    }
    return null;
  }}