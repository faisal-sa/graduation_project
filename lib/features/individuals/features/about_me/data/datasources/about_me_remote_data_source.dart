import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p;

abstract class AboutMeRemoteDataSource {
  Future<String?> uploadVideo(File videoFile, String userId);
  Future<void> updateProfileData(
    String userId,
    String summary,
    String? videoUrl,
  );
  Future<void> deleteVideoData(String userId);
}

@LazySingleton(as: AboutMeRemoteDataSource)
class AboutMeRemoteDataSourceImpl implements AboutMeRemoteDataSource {
  final SupabaseClient _supabase;

  AboutMeRemoteDataSourceImpl(this._supabase);

  @override
  Future<String?> uploadVideo(File videoFile, String userId) async {
    try {
      final fileExt = p.extension(videoFile.path);

      final filePath = '$userId/intro_video$fileExt';

      await _supabase.storage
          .from('profile_videos')
          .upload(
            filePath,
            videoFile,
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl = _supabase.storage
          .from('profile_videos')
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload video: $e');
    }
  }

  @override
  Future<void> updateProfileData(
    String userId,
    String summary,
    String? videoUrl,
  ) async {
    try {
      final Map<String, dynamic> updates = {
        'about_me': summary,
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (videoUrl != null) {
        updates['intro_video_url'] = videoUrl;
      }

      await _supabase.from('profiles').update(updates).eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile data: $e');
    }
  }

  @override
  Future<void> deleteVideoData(String userId) async {
    try {
      final filePath = '$userId/intro_video.mp4';

      try {
        await _supabase.storage.from('profile_videos').remove([filePath]);
      } catch (e) {
        debugPrint("Storage delete warning: $e");
      }

      await _supabase
          .from('profiles')
          .update({'intro_video_url': null})
          .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to delete video data: $e');
    }
  }
}
