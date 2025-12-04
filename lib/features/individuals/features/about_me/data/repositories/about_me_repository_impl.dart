import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/about_me_repository.dart';
import '../datasources/about_me_remote_data_source.dart';

@LazySingleton(as: AboutMeRepository)
class AboutMeRepositoryImpl implements AboutMeRepository {
  final AboutMeRemoteDataSource _dataSource;
  final SupabaseClient _supabaseClient;

  AboutMeRepositoryImpl(this._dataSource, this._supabaseClient);

  @override
  Future<String?> updateAboutMe({
    required String summary,
    String? videoPath,
  }) async {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated");
    }

    String? newVideoUrl;

    if (videoPath != null && videoPath.isNotEmpty) {
      final file = File(videoPath);
      if (file.existsSync()) {
        newVideoUrl = await _dataSource.uploadVideo(file, currentUser.id);
      }
    }

    await _dataSource.updateProfileData(currentUser.id, summary, newVideoUrl);

    return newVideoUrl;
  }

  @override
  Future<void> deleteVideo() async {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated");
    }

    await _dataSource.deleteVideoData(currentUser.id);
  }
}
