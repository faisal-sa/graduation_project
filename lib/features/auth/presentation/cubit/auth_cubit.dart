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

  Future<void> signUpUser({
    required String email,
    required String password,
    required String role,
  }) async {
    emit(AuthState.loading());
    final signUpResult = await signUp(
      SignUpParams(email: email, password: password, role: role),
    );

    await signUpResult.when(
      (success) async {
        // Resend OTP after successful signup (for signup type)
        final otpResult = await resendOTP(ResendOTPParams(email: email));
        otpResult.when(
          (success) {
            emit(AuthState.otpSent(email));
          },
          (error) {
            emit(AuthState.error(_getErrorMessage(error)));
          },
        );
      },
      (error) async {
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
