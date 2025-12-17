import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/no_params.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/resend_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/send_password_reset_otp.dart';
import '../../domain/usecases/verify_password_reset_otp.dart';
import '../../domain/usecases/update_password.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../../CRinfo/domain/usecases/get_cr_info.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final SignUp signUp;
  final Login login;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SendOTP sendOTP;
  final ResendOTP resendOTP;
  final VerifyOTP verifyOTP;
  final ResetPassword resetPasswordOTP;
  final SendPasswordResetOTP sendPasswordResetOTP;
  final VerifyPasswordResetOTP verifyPasswordResetOTP;
  final UpdatePassword updatePassword;
  final GetCrInfo getCrInfo;

  AuthCubit({
    required this.signUp,
    required this.login,
    required this.signOut,
    required this.getCurrentUser,
    required this.sendOTP,
    required this.resendOTP,
    required this.verifyOTP,
    required this.resetPasswordOTP,
    required this.sendPasswordResetOTP,
    required this.verifyPasswordResetOTP,
    required this.updatePassword,
    required this.getCrInfo,
  }) : super(AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    emit(AuthState.loading());
    final result = await getCurrentUser(NoParams());
    result.when(
      (user) {
        if (user != null) {
          emit(AuthState.authenticated(user));
        } else {
          emit(AuthState.unauthenticated());
        }
      },
      (error) {
        emit(AuthState.unauthenticated());
      },
    );
  }

  String _getErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred';
  }

  /// Validates if a CR number is valid by checking if it returns valid CR info
  /// Returns true if valid, false if invalid
  Future<bool> validateCrNumber(String crNumber) async {
    print('[CR Validation] Starting validation for CR number: $crNumber');
    try {
      print('[CR Validation] Calling getCrInfo API...');
      final crInfo = await getCrInfo(crNumber);
      print('[CR Validation] CR number is VALID. Got response: ${crInfo.name}');
      // If no exception is thrown, CR number is valid
      return true;
    } catch (e) {
      print('[CR Validation] CR number is INVALID. Error: $e');
      print('[CR Validation] Error type: ${e.runtimeType}');
      print('[CR Validation] Error details: ${e.toString()}');
      // If exception is thrown, CR number is invalid
      return false;
    }
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String role,
    required String? crNumber,
  }) async {
    print('[SignUp] Starting signup process');
    print('[SignUp] Email: $email');
    print('[SignUp] Role: $role');
    print('[SignUp] CR Number: $crNumber');

    // Validate CR number if role is Company
    if (role == 'Company' && crNumber != null && crNumber.isNotEmpty) {
      print('[SignUp] Company role detected, validating CR number...');
      final isValid = await validateCrNumber(crNumber);
      print('[SignUp] CR validation result: $isValid');
      if (!isValid) {
        print('[SignUp] CR validation failed, aborting signup');
        emit(AuthState.error('Invalid CR number. Please check and try again.'));
        return;
      }
      print('[SignUp] CR validation passed, proceeding with signup');
    } else {
      print(
        '[SignUp] No CR validation needed (role: $role, crNumber: $crNumber)',
      );
    }

    print('[SignUp] Emitting loading state...');
    emit(AuthState.loading());

    print('[SignUp] Calling signUp usecase...');
    final signUpResult = await signUp(
      SignUpParams(email: email, password: password, role: role),
    );

    print('[SignUp] SignUp result received');
    await signUpResult.when(
      (success) async {
        print('[SignUp] SignUp successful! User ID: ${success.id}');
        print('[SignUp] Resending OTP to email: $email');
        // Resend OTP after successful signup (for signup type)
        final otpResult = await resendOTP(ResendOTPParams(email: email));
        otpResult.when(
          (success) {
            print('[SignUp] OTP sent successfully');
            emit(AuthState.otpSent(email));
          },
          (error) {
            // Silently proceed to OTP verification even if resend fails
            // User can request OTP again from the verification page
            print(
              '[SignUp] OTP resend failed, but proceeding to verification page',
            );
            emit(AuthState.otpSent(email));
          },
        );
      },
      (error) async {
        print('[SignUp] SignUp failed: ${_getErrorMessage(error)}');
        print('[SignUp] Error type: ${error.runtimeType}');
        emit(AuthState.error(_getErrorMessage(error)));
      },
    );
  }

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(AuthState.loading());
    final result = await login(LoginParams(email: email, password: password));

    result.when(
      (user) {
        emit(AuthState.authenticated(user, role: user.role));
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error)));
      },
    );
  }

  Future<void> sendOTPToEmail(String email) async {
    emit(AuthState.loading());

    final result = await sendOTP(SendOTPParams(email: email));

    result.when(
      (success) {
        emit(AuthState.otpSent(email));
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error)));
      },
    );
  }

  Future<void> resendOTPToEmail(String email) async {
    emit(AuthState.loading());

    final result = await resendOTP(ResendOTPParams(email: email));

    result.when(
      (success) {
        emit(AuthState.otpSent(email));
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error)));
      },
    );
  }

  Future<void> verifyOTPCode({
    required String email,
    required String token,
  }) async {
    emit(AuthState.loading());

    final result = await verifyOTP(VerifyOTPParams(email: email, token: token));

    result.when(
      (user) {
        emit(AuthState.authenticated(user, role: user.role));
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error)));
      },
    );
  }

  Future<void> sendPasswordResetOTPToEmail({required String email}) async {
    emit(AuthState.loading());
    final result = await sendPasswordResetOTP(
      SendPasswordResetOTPParams(email: email.trim()),
    );

    result.when(
      (success) => emit(AuthState.passwordResetEmailSent(email.trim())),
      (error) => emit(AuthState.error(_getErrorMessage(error))),
    );
  }

  Future<void> verifyPasswordResetOTPCode({
    required String email,
    required String token,
  }) async {
    emit(AuthState.loading());
    final result = await verifyPasswordResetOTP(
      VerifyPasswordResetOTPParams(email: email.trim(), token: token.trim()),
    );

    result.when(
      (user) => emit(AuthState.passwordResetVerified(user)),
      (error) => emit(AuthState.error(_getErrorMessage(error))),
    );
  }

  Future<void> updateUserPassword({required String newPassword}) async {
    emit(AuthState.loading());
    final result = await updatePassword(
      UpdatePasswordParams(newPassword: newPassword),
    );

    result.when(
      (user) => emit(AuthState.authenticated(user, role: user.role)),
      (error) => emit(AuthState.error(_getErrorMessage(error))),
    );
  }

  Future<void> signOutUser() async {
    emit(AuthState.loading());
    final result = await signOut(NoParams());
    result.when(
      (success) {
        emit(AuthState.unauthenticated());
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error)));
      },
    );
  }
}
