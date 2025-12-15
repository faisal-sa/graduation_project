import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseException implements Exception {
  final String message;
  SupabaseException(this.message);
}

@lazySingleton
class SearchRemoteDataSource {
  final SupabaseClient supabase;

  SearchRemoteDataSource(this.supabase);

  Future<List<Map<String, dynamic>>> searchCandidates({
    String? location,
    List<String>? skills,
    List<String>? employmentTypes,
    bool? canRelocate,
    List<String>? languages,
    List<String>? workModes,
    String? jobTitle,
    List<String>? targetRoles,
  }) async {
    try {
      PostgrestFilterBuilder query = supabase
          .from('profiles')
          .select(
            'id, first_name, last_name, job_title, location, skills, avatar_url',
          );

      if (location != null && location.isNotEmpty) {
        query = query.ilike('location', '%$location%');
      }

      if (skills != null && skills.isNotEmpty) {
        query = query.overlaps('skills', skills);
      }

      if (employmentTypes != null && employmentTypes.isNotEmpty) {
        query = query.overlaps('employment_types', employmentTypes);
      }

      if (canRelocate != null) {
        query = query.eq('can_relocate', canRelocate);
      }

      if (languages != null && languages.isNotEmpty) {
        query = query.overlaps('languages', languages);
      }

      if (workModes != null && workModes.isNotEmpty) {
        query = query.overlaps('work_modes', workModes);
      }

      if (jobTitle != null && jobTitle.isNotEmpty) {
        query = query.ilike('job_title', '%$jobTitle%');
      }

      if (targetRoles != null && targetRoles.isNotEmpty) {
        query = query.overlaps('target_roles', targetRoles);
      }

      final result = await query;

      final List<Map<String, dynamic>> candidates =
          List<Map<String, dynamic>>.from(result);

      final companyId = supabase.auth.currentUser?.id;

      for (var candidate in candidates) {
        candidate['bookmarked'] = false;
      }

      if (companyId != null && candidates.isNotEmpty) {
        try {
          final bookmarksResponse = await supabase
              .from('company_bookmarks')
              .select('candidate_id')
              .eq('company_id', companyId);

          final Set<String> bookmarkedIds = (bookmarksResponse as List)
              .map((e) => e['candidate_id'] as String)
              .toSet();

          for (var candidate in candidates) {
            if (bookmarkedIds.contains(candidate['id'])) {
              candidate['bookmarked'] = true;
            }
          }
        } catch (e) {
          print("Error fetching bookmarks: $e");
        }
      }

      return candidates;
    } on PostgrestException catch (e) {
      throw SupabaseException(e.message ?? 'Database error during search.');
    } catch (e) {
      throw SupabaseException('Unexpected error: ${e.toString()}');
    }
  }
}
