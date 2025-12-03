import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EnvConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static Future<void> load() async {
    try {
      if (kDebugMode) {
        await dotenv.load(fileName: ".env");
      }
    } catch (e) {
      debugPrint("ERROR: COULDN'T LOAD ENV FILE $e");
    }
  }
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SupabaseClient> get supabaseClient async {
    await EnvConfig.load();

    final supabase = await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );

    return supabase.client;
  }
  
  @preResolve
  Future<SharedPreferences> get prefs async {
    return await SharedPreferences.getInstance();
  }


}
