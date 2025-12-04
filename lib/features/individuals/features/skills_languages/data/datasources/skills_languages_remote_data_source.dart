import 'package:graduation_project/features/individuals/features/skills_languages/data/models/skills_languages_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SkillsLanguagesRemoteDataSource {
  Future<void> updateSkills(List<String> skills);
  Future<void> updateLanguages(List<String> languages);
  Future<SkillsAndLanguagesModel> getData();
}

@LazySingleton(as: SkillsLanguagesRemoteDataSource)
class SkillsLanguagesRemoteDataSourceImpl
    implements SkillsLanguagesRemoteDataSource {
  final SupabaseClient _supabaseClient;

  SkillsLanguagesRemoteDataSourceImpl(this._supabaseClient);

  String get _userId => _supabaseClient.auth.currentUser!.id;

  @override
  Future<void> updateSkills(List<String> skills) async {
    await _supabaseClient
        .from('profiles')
        .update({'skills': skills})
        .eq('id', _userId);
  }

  @override
  Future<void> updateLanguages(List<String> languages) async {
    await _supabaseClient
        .from('profiles')
        .update({'languages': languages})
        .eq('id', _userId);
  }

  @override
  Future<SkillsAndLanguagesModel> getData() async {
    final response = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', _userId)
        .single();

    return SkillsAndLanguagesModel.fromJson(response);
  }
}
