import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseException implements Exception {
  final String message;
  SupabaseException(this.message);
}

@lazySingleton
class BookmarksRemoteDataSource {
  final SupabaseClient supabase;

  BookmarksRemoteDataSource(this.supabase);

  T _handleSupabaseCall<T>(Function() call) {
    try {
      return call();
    } on PostgrestException catch (e) {
      throw SupabaseException(e.message );
    } catch (e) {
      throw SupabaseException('Unexpected error: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarks(String companyId) async {
    return await _handleSupabaseCall(() async {
      final result = await supabase
          .from('company_bookmarks')
          .select(
            'candidate_id, profiles(first_name, last_name, skills, location, job_title, avatar_url,id)',
          )
          .eq('company_id', companyId);

      return List<Map<String, dynamic>>.from(result);
    });
  }

  Future<void> addBookmark(String companyId, String candidateId) async {
    return await _handleSupabaseCall(() async {
      if (companyId.isEmpty || candidateId.isEmpty) {
        throw SupabaseException('Invalid IDs provided.');
      }

      await supabase
          .from('company_bookmarks')
          .upsert(
            {'company_id': companyId, 'candidate_id': candidateId},
            onConflict: 'company_id, candidate_id',
            ignoreDuplicates: true,
          );
    });
  }

  Future<void> removeBookmark(String companyId, String candidateId) async {
    return await _handleSupabaseCall(() async {
      await supabase
          .from('company_bookmarks')
          .delete()
          .eq('company_id', companyId)
          .eq('candidate_id', candidateId);
    });
  }
}
