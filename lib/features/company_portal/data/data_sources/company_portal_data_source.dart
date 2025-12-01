// lib/features/company_portal/data/data_sources/company_remote_data_source.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';

// Custom Data Layer Exception for mapping Supabase errors to Domain Failures
// lib/features/company_portal/data/data_sources/company_remote_data_source.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';

// Custom Data Layer Exception
class SupabaseException implements Exception {
  final String message;
  SupabaseException(this.message);
  @override
  String toString() => 'SupabaseException: $message';
}

@injectable
class CompanyRemoteDataSource {
  final SupabaseClient supabase;
  CompanyRemoteDataSource(this.supabase);

  T _handleSupabaseCall<T>(Function() call) {
    // (Error handling logic remains the same)
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

  // -----------------------------------------------------
  // Company Registration (Inserts empty name)
  // -----------------------------------------------------
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
        throw SupabaseException('Signup failed. No valid user ID returned.');
      }

      // Insert empty string for company_name to force profile completion
      final response = await supabase
          .from('companies')
          .insert({
            'user_id': user.id,
            'email': email,
            'company_name': '',
            'industry': '',
            'description': '',
            'city': '',
            'company_size': '',
          })
          .select('*')
          .single();

      return Map<String, dynamic>.from(response);
    });
  }

  // -----------------------------------------------------
  // Check Company Status (FIXED: Payment check removed)
  // -----------------------------------------------------
  Future<Map<String, dynamic>> checkCompanyStatus(String userId) async {
    return await _handleSupabaseCall(() async {
      final client = supabase;

      // 1. Get Company Profile and the mandatory field (company_name)
      final companyResponse = await client
          .from('companies')
          .select('id, company_name')
          .eq('user_id', userId)
          .maybeSingle();

      final recordExists = companyResponse != null;
      final rawCompanyName = recordExists
          ? companyResponse!['company_name'] as String?
          : null;

      // Trim whitespace and check if the name is NOT empty
      final trimmedCompanyName = rawCompanyName?.trim();
      final hasProfile =
          recordExists && (trimmedCompanyName?.isNotEmpty ?? false);

      // 🛑 FIX: Since payment is removed, we hardcode hasPaid to true.
      const hasPaid = true;

      return {'hasProfile': hasProfile, 'hasPaid': hasPaid};
    });
  }

  // -----------------------------------------------------
  // (The rest of the methods: getCompanyProfile, updateCompanyProfile,
  // searchCandidates, addCandidateBookmark, getCompanyBookmarks remain unchanged)
  // -----------------------------------------------------

  Future<Map<String, dynamic>?> getCompanyProfile(String userId) async {
    // ... (implementation unchanged)
    return null; // Placeholder
  }

  Future<Map<String, dynamic>> updateCompanyProfile(
    String id,
    Map<String, dynamic> data,
  ) async {
    // ... (implementation unchanged)
    return {}; // Placeholder
  }

  Future<List<Map<String, dynamic>>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  }) async {
    // ... (implementation unchanged)
    return []; // Placeholder
  }

  Future<void> addCandidateBookmark(
    String companyId,
    String candidateId,
  ) async {
    // ... (implementation unchanged)
  }
  Future<List<Map<String, dynamic>>> getCompanyBookmarks(
    String companyId,
  ) async {
    // ... (implementation unchanged)
    return []; // Placeholder
  }
}
