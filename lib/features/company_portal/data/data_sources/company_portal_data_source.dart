import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseException implements Exception {
  final String message;
  SupabaseException(this.message);

  @override
  String toString() => message;
}

@LazySingleton()
class CompanyRemoteDataSource {
  final SupabaseClient supabase;
  CompanyRemoteDataSource(this.supabase);

  T _handleSupabaseCall<T>(Function() call) {
    try {
      return call();
    } on PostgrestException catch (e) {
      throw SupabaseException(e.message);
    } on AuthException catch (e) {
      throw SupabaseException(e.message);
    } on SupabaseException {
      rethrow;
    } catch (e) {
      throw SupabaseException('حدث خطأ غير متوقع: ${e.toString()}');
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
        throw SupabaseException('فشل إنشاء المستخدم.');
      }

      final response = await supabase
          .from('companies')
          .insert({
            'user_id': user.id,
            'email': email,
            'company_name': 'New Company',
            'industry': 'Pending',
          })
          .select()
          .single();

      return Map<String, dynamic>.from(response);
    });
  }

  Future<Map<String, dynamic>?> getCompanyProfile(String userId) async {
    return await _handleSupabaseCall(() async {
      if (userId.isEmpty) {
        throw SupabaseException('Invalid userId');
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
      final currentUser = supabase.auth.currentUser;

      if (currentUser == null) {
        throw SupabaseException('يجب تسجيل الدخول أولاً.');
      }

      final safeData = Map<String, dynamic>.from(data);
      safeData.remove('id');
      safeData.remove('user_id');
      safeData.remove('created_at');
      safeData['updated_at'] = DateTime.now().toIso8601String();

      final result = await supabase
          .from('companies')
          .update(safeData)
          .eq('user_id', currentUser.id)
          .select()
          .single();

      return Map<String, dynamic>.from(result);
    });
  }

  Future<Map<String, dynamic>> checkCompanyStatus(String userId) async {
    return await _handleSupabaseCall(() async {
      bool hasProfile = false;
      bool hasPaid = false;

      final companyResponse = await supabase
          .from('companies')
          .select('id, industry')
          .eq('user_id', userId)
          .maybeSingle();

      if (companyResponse != null) {
        final industry = companyResponse['industry'] as String?;
        if (industry != null && industry.isNotEmpty && industry != 'Pending') {
          hasProfile = true;
        }
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
