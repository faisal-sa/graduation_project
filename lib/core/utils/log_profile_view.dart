import 'package:graduation_project/core/di/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> logProfileView(String candidateId) async {
  final supabase = serviceLocator.get<SupabaseClient>();
  if (candidateId == supabase.auth.currentUser?.id) return;

  try {
    await supabase.rpc(
      'track_profile_view',
      params: {'target_user_id': candidateId},
    );
  } catch (e) {
    print("Error logging view: $e");
  }
}


