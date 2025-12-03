import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:graduation_project/features/payment/export_payment.dart';
import 'package:injectable/injectable.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentResponseModel> processPayment(PaymentRequestModel request);
}

@LazySingleton(as: PaymentRemoteDataSource)
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  static const String _baseUrl = 'https://api.moyasar.com';
  static const String _apiKey =
      'pk_test_oCkYSAKky59z4HrK2erLewjzCU1CeVQxLsE37KuK';
  static const String _apiPassword = '';

  final Dio _dio;

  PaymentRemoteDataSourceImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ) {
    _dio.options.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('$_apiKey:$_apiPassword'))}';
  }

  @override
  Future<PaymentResponseModel> processPayment(
    PaymentRequestModel request,
  ) async {
    try {
      final response = await _dio.post('/v1/payments', data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          return PaymentResponseModel.fromJson(
            response.data as Map<String, dynamic>,
          );
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: 'Invalid response from server',
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Payment request failed with status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final errorMessage =
            e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Payment failed (${statusCode ?? 'Unknown'})';
        throw Exception(errorMessage);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please try again');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'Connection error. Please check your internet connection',
        );
      } else {
        throw Exception('Unexpected error: ${e.message}');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Payment processing error: ${e.toString()}');
    }
  }
}
