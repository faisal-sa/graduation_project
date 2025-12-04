abstract class AboutMeRepository {
  Future<String?> updateAboutMe({required String summary, String? videoPath});
  Future<void> deleteVideo();
}
