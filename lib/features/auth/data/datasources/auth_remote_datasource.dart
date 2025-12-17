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

  Future<void> resetPassword({required String email});

  Future<void> sendPasswordResetOTP({required String email});

  Future<UserModel> verifyPasswordResetOTP({
    required String email,
    required String token,
  });

  Future<UserModel> updatePassword({required String newPassword});

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
    print('[DataSource] signUp called');
    print('[DataSource] Email: $email, Role: $role');
    try {
      print('[DataSource] Calling Supabase auth.signUp...');
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null,
        data: {'role': role},
      );
      print('[DataSource] Supabase response received');
      print('[DataSource] Response user: ${response.user?.id}');
      print('[DataSource] Response session: ${response.session != null}');

      if (response.user == null) {
        print('[DataSource] User is null in response');
        throw Exception('Sign up failed: User is null');
      }

      print('[DataSource] Creating UserModel...');
      final userModel = UserModel(
        id: response.user!.id,
        email: response.user!.email ?? email,
        phone: response.user!.phone,
        role: role,
      );
      print('[DataSource] UserModel created successfully');
      return userModel;
    } catch (e) {
      print('[DataSource] signUp failed with error: $e');
      print('[DataSource] Error type: ${e.runtimeType}');
      print('[DataSource] Error stack: ${StackTrace.current}');
      rethrow;
    }
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
  Future<void> resetPassword({required String email}) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> sendPasswordResetOTP({required String email}) async {
    // For password recovery, Supabase sends OTP via resetPasswordForEmail
    // The OTP can then be verified using verifyOTP with OtpType.recovery
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<UserModel> verifyPasswordResetOTP({
    required String email,
    required String token,
  }) async {
    final response = await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.recovery,
    );

    if (response.user == null) {
      throw Exception('Password reset OTP verification failed: User is null');
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
  Future<UserModel> updatePassword({required String newPassword}) async {
    final response = await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );

    if (response.user == null) {
      throw Exception('Password update failed: User is null');
    }

    final userMetadata = response.user!.userMetadata;
    final appMetadata = response.user!.appMetadata;
    final role =
        (userMetadata?['role'] ?? appMetadata['role']) as String? ??
        'Individual';

    return UserModel(
      id: response.user!.id,
      email: response.user!.email ?? '',
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
