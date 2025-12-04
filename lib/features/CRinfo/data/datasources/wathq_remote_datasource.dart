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
            'ApiKey': 'Gt2I30EQ6YaSAbe4vN9kcwlypG9cWp98',
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

      return CrInfoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Failed to fetch CR info: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error parsing CR info: ${e.toString()}');
    }
  }
}
