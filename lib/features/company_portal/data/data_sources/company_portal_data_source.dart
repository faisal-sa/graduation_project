// lib/features/company_portal/data/data_sources/company_remote_data_source.dart

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Custom Data Layer Exception
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

  // Universal error handling wrapper for Supabase calls
  T _handleSupabaseCall<T>(Function() call) {
    try {
      // NOTE: We assume the 'call' function is an async function being awaited
      // by the calling Future method.
      return call();
    } on PostgrestException catch (e) {
      // Catches database errors (like table not found, which was the issue)
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

      // Create initial company profile entry
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
      if (userId.isEmpty)
        throw SupabaseException('Invalid userId: cannot be empty.');

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
      if (supabase.auth.currentUser!.id.isEmpty)
        throw SupabaseException('Invalid company ID: cannot be empty.');

      print(data);

      data.addAll({
        'id': supabase.auth.currentUser!.id,
        'user_id': supabase.auth.currentUser!.id,
      });

      final result = await supabase
          .from('companies')
          .upsert(data)
          .eq('id', supabase.auth.currentUser!.id.isEmpty)
          .select()
          .single();

      return result;
    });
  }

  Future<List<Map<String, dynamic>>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  }) async {
    return await _handleSupabaseCall(() async {
      final query = await supabase
          .from('profiles')
          .select('*')
          .eq('location', city ?? "");
      print(query);
      return List<Map<String, dynamic>>.from(query);
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

      await supabase.from('company_bookmarks').insert({
        'company_id': companyId,
        'candidate_id': candidateId,
      });
    });
  }

  Future<List<Map<String, dynamic>>> getCompanyBookmarks(
    String companyId,
  ) async {
    return await _handleSupabaseCall(() async {
      if (companyId.isEmpty) {
        throw SupabaseException('Invalid companyId: cannot be empty.');
      }

      final result = await supabase
          .from('company_bookmarks')
          .select('candidate_id, candidates(full_name,skills,city,id)')
          .eq('company_id', companyId);

      return List<Map<String, dynamic>>.from(result);
    });
  }

  Future<Map<String, dynamic>> checkCompanyStatus(String userId) async {
    return await _handleSupabaseCall(() async {
      final client = supabase;
      bool hasProfile = false;
      bool hasPaid = false; // Corresponds to having an active subscription

      // Step 1: Check if the company profile exists
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
