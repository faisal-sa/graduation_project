import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyRemoteDataSource {
  final SupabaseClient supabase;
  CompanyRemoteDataSource(this.supabase);

  // -----------------------------------------------------
  // Company registration
  // -----------------------------------------------------
  Future<Map<String, dynamic>> registerCompany(
    String email,
    String password,
  ) async {
    // Example: sign‑up the company user
    final authResponse = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = authResponse.user;

    // Create an empty company record tied to this user
    final response = await supabase
        .from('companies')
        .insert({'user_id': user?.id, 'email': email})
        .select()
        .single();

    return Map<String, dynamic>.from(response);
  }

  // -----------------------------------------------------
  // Get company profile by user id
  // -----------------------------------------------------
  Future<Map<String, dynamic>?> getCompanyProfile(String userId) async {
    final result = await supabase
        .from('companies')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    return result == null ? null : Map<String, dynamic>.from(result);
  }

  // -----------------------------------------------------
  // Update existing company profile
  // -----------------------------------------------------
  Future<Map<String, dynamic>> updateCompanyProfile(
    String id,
    Map<String, dynamic> data,
  ) async {
    final result = await supabase
        .from('companies')
        .update(data)
        .eq('id', id)
        .select()
        .single();
    return Map<String, dynamic>.from(result);
  }

  // -----------------------------------------------------
  // Search candidates
  // -----------------------------------------------------
  Future<List<Map<String, dynamic>>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  }) async {
    final query = supabase.from('candidates').select();

    if (city != null && city.isNotEmpty) {
      query.eq('city', city);
    }
    if (skill != null && skill.isNotEmpty) {
      query.ilike('skills', '%$skill%');
    }
    if (experience != null && experience.isNotEmpty) {
      query.ilike('experience', '%$experience%');
    }

    final result = await query;
    return List<Map<String, dynamic>>.from(result);
  }

  // -----------------------------------------------------
  // Bookmark management
  // -----------------------------------------------------
  Future<void> addCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    await supabase.from('company_bookmarks').insert({
      'company_id': companyId,
      'candidate_id': candidateId,
    });
  }

  Future<List<Map<String, dynamic>>> getCompanyBookmarks(
    String companyId,
  ) async {
    final result = await supabase
        .from('company_bookmarks')
        .select('candidate_id, candidates(full_name,skills,city)')
        .eq('company_id', companyId);
    return List<Map<String, dynamic>>.from(result);
  }
}
