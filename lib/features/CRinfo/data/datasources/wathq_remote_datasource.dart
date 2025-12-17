import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/cr_info_model.dart';

abstract class WathqRemoteDataSource {
  Future<CrInfoModel> getCrInfo(String crNumber);
}

@LazySingleton(as: WathqRemoteDataSource)
class WathqRemoteDataSourceImpl implements WathqRemoteDataSource {
  final Dio _dio;

  WathqRemoteDataSourceImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.wathq.sa',
          headers: {
            'ApiKey': 'SOr9SSFpDLQKgDb6wq2sdBccqNKVvNop',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

  @override
  Future<CrInfoModel> getCrInfo(String crNumber) async {
    try {
      final response = await _dio.get(
        '/commercial-registration/info/$crNumber',
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      print('[Wathq API] Response received: ${response.data}');
      return CrInfoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response != null) {
        print(
          '[Wathq API] DioException: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
        print('[Wathq API] Response data: ${e.response?.data}');
        throw Exception(
          'Failed to fetch CR info: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        print('[Wathq API] Network error: ${e.message}');
        throw Exception('Network error: ${e.message}');
      }
    } catch (e, stackTrace) {
      print('[Wathq API] Error parsing CR info: $e');
      print('[Wathq API] Stack trace: $stackTrace');
      throw Exception('Error parsing CR info: ${e.toString()}');
    }
  }
}
