// lib/features/company_portal/data/data_sources/company_remote_data_source.dart
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseException implements Exception {
  final String message;
  SupabaseException(this.message);

  @override
  String toString() => 'SupabaseException: $message';
}

@LazySingleton()
class CompanyRemoteDataSource {
  final SupabaseClient supabase;
  CompanyRemoteDataSource(this.supabase);

  T _handleSupabaseCall<T>(Function() call) {
    try {
      return call();
    } on PostgrestException catch (e) {
      throw SupabaseException(e.message ?? 'A database error occurred.');
    } on AuthException catch (e) {
      throw SupabaseException(e.message ?? 'An authentication error occurred.');
    } on SupabaseException {
      rethrow;
    } catch (e) {
      throw SupabaseException('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> registerCompany(
    String email,
    String password,
  ) async {
    return await _handleSupabaseCall(() async {
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null || user.id.isEmpty) {
        throw SupabaseException(
          'No valid user ID. Please verify signup and retry.',
        );
      }
      final response = await supabase
          .from('companies')
          .insert({
            'user_id': user.id,
            'email': email,
            'company_name': 'Untitled Company',
            'industry': '',
          })
          .select('*')
          .single();
      return Map<String, dynamic>.from(response);
    });
  }

  Future<Map<String, dynamic>?> getCompanyProfile(String userId) async {
    return await _handleSupabaseCall(() async {
      if (userId.isEmpty) {
        throw SupabaseException('Invalid userId: cannot be empty.');
      }

      final result = await supabase
          .from('companies')
          .select()
          .eq('user_id', userId)
          .maybeSingle();
      return result == null ? null : Map<String, dynamic>.from(result);
    });
  }

  Future<Map<String, dynamic>> updateCompanyProfile(
    Map<String, dynamic> data,
  ) async {
    return await _handleSupabaseCall(() async {
      if (supabase.auth.currentUser!.id.isEmpty) {
        throw SupabaseException('Invalid company ID: cannot be empty.');
      }

      data.addAll({
        'id': supabase.auth.currentUser!.id,
        'user_id': supabase.auth.currentUser!.id,
      });
      final result = await supabase
          .from('companies')
          .upsert(data)
          .eq('user_id', supabase.auth.currentUser!.id)
          .select()
          .single();
      return result;
    });
  }

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
    return await _handleSupabaseCall(() async {
      PostgrestFilterBuilder query = supabase
          .from('profiles')
          .select(
            'id, first_name, last_name, job_title, location, skills,avatar_url',
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
      return List<Map<String, dynamic>>.from(result);
    });
  }

  Future<void> addCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    return await _handleSupabaseCall(() async {
      if (companyId.isEmpty || candidateId.isEmpty) {
        throw SupabaseException(
          'Invalid uuid: companyId or candidateId cannot be empty.',
        );
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

  Future<void> removeCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    return await _handleSupabaseCall(() async {
      await supabase
          .from('company_bookmarks')
          .delete()
          .eq('company_id', companyId)
          .eq('candidate_id', candidateId);
    });
  }

  Future<List<Map<String, dynamic>>> getCompanyBookmarks(
    String companyId,
  ) async {
    return await _handleSupabaseCall(() async {
      final result = await supabase
          .from('company_bookmarks')
          .select(
            'candidate_id, profiles(first_name, last_name, skills, location, job_title, avatar_url,id)',
          )
          .eq('company_id', companyId);

      print("🔍 Bookmarks Result: $result");

      return List<Map<String, dynamic>>.from(result);
    });
  }

  Future<Map<String, dynamic>> checkCompanyStatus(String userId) async {
    return await _handleSupabaseCall(() async {
      final client = supabase;
      bool hasProfile = false;
      bool hasPaid = false;

      final companyResponse = await client
          .from('companies')
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();
      hasProfile = companyResponse != null;
      final companyId = companyResponse?['id'] as String?;

      if (hasProfile && companyId != null) {
        final subscriptionResponse = await client
            .from('subscriptions')
            .select('status')
            .eq('user_id', userId)
            .eq('status', 'active')
            .maybeSingle();
        hasPaid = subscriptionResponse != null;
      }

      return {'hasProfile': hasProfile, 'hasPaid': hasPaid};
    });
  }

  Future<void> verifyCompanyQR(String qrCodeData) async {
    return await _handleSupabaseCall(() async {
      await supabase.rpc('verify_company_qr', params: {'qr_data': qrCodeData});
    });
  }
}
