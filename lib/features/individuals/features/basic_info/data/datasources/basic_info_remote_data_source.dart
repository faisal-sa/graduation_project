import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/basic_info_model.dart';

abstract class BasicInfoRemoteDataSource {
  Future<void> saveBasicInfo(BasicInfoModel model);
}

@LazySingleton(as: BasicInfoRemoteDataSource)
class BasicInfoRemoteDataSourceImpl implements BasicInfoRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BasicInfoRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<void> saveBasicInfo(BasicInfoModel model) async {
    final userId = _supabaseClient.auth.currentUser!.id;

    final data = model.toJson();

    data['id'] = userId;

    await _supabaseClient.from('profiles').upsert(data);
  }
}
