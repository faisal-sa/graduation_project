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

  AuthCubit({
    required this.signUp,
    required this.login,
    required this.signOut,
    required this.getCurrentUser,
    required this.sendOTP,
    required this.resendOTP,
    required this.verifyOTP,
  }) : super(AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await getCurrentUser(NoParams());
    result.when(
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
      (error) {
        emit(AuthUnauthenticated());
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
    emit(AuthLoading());
    final result = await signUp(
      SignUpParams(email: email, password: password, role: role),
    );

    result.when(
      (success) {
        // After signup, OTP is usually sent automatically
        emit(OTPSent(email));
      },
      (error) {
        emit(AuthError(_getErrorMessage(error)));
      },
    );
  }

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await login(LoginParams(email: email, password: password));

    result.when(
      (user) {
        emit(AuthAuthenticated(user, role: user.role));
      },
      (error) {
        emit(AuthError(_getErrorMessage(error)));
      },
    );
  }

  Future<void> sendOTPToEmail(String email) async {
    emit(AuthLoading());

    final result = await sendOTP(SendOTPParams(email: email));

    result.when(
      (success) {
        emit(OTPSent(email));
      },
      (error) {
        emit(AuthError(_getErrorMessage(error)));
      },
    );
  }

  Future<void> resendOTPToEmail(String email) async {
    emit(AuthLoading());

    final result = await resendOTP(ResendOTPParams(email: email));

    result.when(
      (success) {
        emit(OTPSent(email));
      },
      (error) {
        emit(AuthError(_getErrorMessage(error)));
      },
    );
  }

  Future<void> verifyOTPCode({
    required String email,
    required String token,
  }) async {
    emit(AuthLoading());

    final result = await verifyOTP(VerifyOTPParams(email: email, token: token));

    result.when(
      (user) {
        emit(AuthAuthenticated(user, role: user.role));
      },
      (error) {
        emit(AuthError(_getErrorMessage(error)));
      },
    );
  }
}
