import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/work_experience_model.dart';

abstract class WorkExperienceRemoteDataSource {
  Future<void> addWorkExperience(WorkExperienceModel model);
  Future<void> updateWorkExperience(WorkExperienceModel model);
  Future<void> deleteWorkExperience(String id);
  Future<List<WorkExperienceModel>> getWorkExperiences();
}

@LazySingleton(as: WorkExperienceRemoteDataSource)
class WorkExperienceRemoteDataSourceImpl
    implements WorkExperienceRemoteDataSource {
  final SupabaseClient _supabaseClient;

  WorkExperienceRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<void> addWorkExperience(WorkExperienceModel model) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _supabaseClient
        .from('work_experiences')
        .insert(model.toJson(userId: user.id));
  }

  @override
  Future<void> updateWorkExperience(WorkExperienceModel model) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    await _supabaseClient
        .from('work_experiences')
        .update(model.toJson(userId: user.id))
        .eq('id', model.id);
  }

  @override
  Future<void> deleteWorkExperience(String id) async {
    await _supabaseClient.from('work_experiences').delete().eq('id', id);
  }

  @override
  Future<List<WorkExperienceModel>> getWorkExperiences() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final response = await _supabaseClient
        .from('work_experiences')
        .select()
        .eq('user_id', user.id)
        .order('start_date', ascending: false);

    final data = response as List<dynamic>;
    return data.map((json) => WorkExperienceModel.fromJson(json)).toList();
  }
}
