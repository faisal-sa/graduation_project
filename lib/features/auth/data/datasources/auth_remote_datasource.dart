import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String role,
  });

  Future<UserModel> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> sendOTP({required String email});

  Future<void> resendOTP({required String email});

  Future<UserModel> verifyOTP({required String email, required String token});

  Future<UserModel?> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSourceImpl(this._supabase);

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: null,
      data: {'role': role},
    );

    if (response.user == null) {
      throw Exception('Sign up failed: User is null');
    }

    return UserModel(
      id: response.user!.id,
      email: response.user!.email ?? email,
      phone: response.user!.phone,
      role: role,
    );
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Sign in failed: User is null');
    }

    final userMetadata = response.user!.userMetadata;
    final appMetadata = response.user!.appMetadata;
    final role =
        (userMetadata?['role'] ?? appMetadata['role']) as String? ??
        'Individual';

    return UserModel(
      id: response.user!.id,
      email: response.user!.email ?? email,
      phone: response.user!.phone,
      role: role,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> sendOTP({required String email}) async {
    await _supabase.auth.signInWithOtp(email: email, emailRedirectTo: null);
  }

  @override
  Future<void> resendOTP({required String email}) async {
    await _supabase.auth.resend(type: OtpType.signup, email: email);
  }

  @override
  Future<UserModel> verifyOTP({
    required String email,
    required String token,
  }) async {
    final response = await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.signup,
    );

    if (response.user == null) {
      throw Exception('OTP verification failed: User is null');
    }
    final userMetadata = response.user!.userMetadata;
    final appMetadata = response.user!.appMetadata;
    final role =
        (userMetadata?['role'] ?? appMetadata['role']) as String? ??
        'Individual';

    return UserModel(
      id: response.user!.id,
      email: response.user!.email ?? email,
      phone: response.user!.phone,
      role: role,
    );
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final userMetadata = user.userMetadata;
    final appMetadata = user.appMetadata;
    final role =
        (userMetadata?['role'] ?? appMetadata['role']) as String? ??
        'Individual';

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      phone: user.phone,
      role: role,
    );
  }
}
