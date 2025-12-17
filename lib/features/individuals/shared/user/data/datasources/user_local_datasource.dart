import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


@injectable
class UserLocalDataSource {
  final SharedPreferences prefs;
  final SupabaseClient supabase; 

  UserLocalDataSource(this.prefs, this.supabase);

  String _getStorageKey(String userId) => 'user_entity_data_$userId';

  Future<UserEntity?> getLastUser() async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint("No logged-in user. Skipping local cache retrieval.");
      return null;
    }

    final key = _getStorageKey(userId);
    final jsonString = prefs.getString(key);

    debugPrint("Getting last user for ID: $userId");

    if (jsonString != null) {
      try {
        return UserEntity.fromJson(jsonDecode(jsonString));
      } catch (e) {
        debugPrint(
          "Local data corrupted for user $userId. Clearing cache. Error: $e",
        );
        await prefs.remove(key);
        return null;
      }
    }
    return null;
  }

  Future<void> cacheUser(UserEntity user) async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint("Cannot cache user: No active session.");
      return;
    }

    final key = _getStorageKey(userId);
    await prefs.setString(key, jsonEncode(user.toJson()));
  }
}