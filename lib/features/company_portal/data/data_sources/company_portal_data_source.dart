import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/company_model.dart';
import '../../domain/entities/company_entity.dart';

class CompanyRemoteDataSource {
  final SupabaseClient supabase;
  CompanyRemoteDataSource(this.supabase);

  Future<CompanyEntity> registerCompany(String email, String password) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'role': 'company'},
    );
    if (response.user == null) throw Exception('فشل في إنشاء الحساب');

    final user = response.user!;
    final inserted = await supabase
        .from('companies')
        .insert({
          'user_id': user.id,
          'email': email,
          'company_name': '',
          'industry': '',
          'description': '',
          'city': '',
          'company_size': '',
          'website': '',
          'phone': '',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    return CompanyModelMapper.fromMap(inserted).toEntity();
  }

  Future<CompanyEntity> getProfile(String userId) async {
    final data = await supabase
        .from('companies')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) throw Exception('لم يتم العثور على بيانات الشركة');
    return CompanyModelMapper.fromMap(data).toEntity();
  }

  Future<CompanyEntity> updateProfile(CompanyEntity company) async {
    final model = CompanyModel.fromEntity(company);
    final res = await supabase
        .from('companies')
        .update(model.toMap())
        .eq('id', model.id)
        .select()
        .single();

    return CompanyModelMapper.fromMap(res).toEntity();
  }

  Future<List<Map<String, dynamic>>> searchCandidates({
    String? city,
    String? skill,
    String? experience,
  }) async {
    var query = supabase.from('profiles').select().eq('role', 'jobseeker');

    if (city != null && city.isNotEmpty) {
      query = query.eq('city', city);
    }
    if (skill != null && skill.isNotEmpty) {
      query = query.ilike('skills', '%$skill%');
    }
    if (experience != null && experience.isNotEmpty) {
      query = query.gte('experience', experience);
    }

    return await query;
  }
}
