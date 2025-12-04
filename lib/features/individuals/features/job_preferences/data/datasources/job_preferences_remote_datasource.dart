import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_preferences_model.dart';

abstract class JobPreferencesRemoteDataSource {
  Future<JobPreferencesModel> getPreferences();
  Future<void> updatePreferences(JobPreferencesModel model);
}

@LazySingleton(as: JobPreferencesRemoteDataSource)
class JobPreferencesRemoteDataSourceImpl
    implements JobPreferencesRemoteDataSource {
  final SupabaseClient supabaseClient;

  JobPreferencesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<JobPreferencesModel> getPreferences() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final response = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return JobPreferencesModel.fromJson(response);
  }

  @override
  Future<void> updatePreferences(JobPreferencesModel model) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await supabaseClient
        .from('profiles')
        .update(model.toJson())
        .eq('id', user.id);
  }
}
