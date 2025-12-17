import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecasesAbstract/no_params.dart';
import '../../domain/usecases/usecases.dart';
import '../../../CRinfo/domain/usecases/get_cr_info.dart';
import 'auth_state.dart';

/// AuthCubit manages the authentication state and actions with business logic
/// and state emission for the UI.
@injectable
class AuthCubit extends Cubit<AuthState> {
  // Use cases injected into AuthCubit for performing respective operations
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

  /// Constructor with dependency injection, always checks authentication status at start
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

  //================== CR Validation Functions =================== //
  //
  /// Checks if a user is currently authenticated and update state accordingly
  Future<void> checkAuthStatus() async {
    emit(AuthState.loading()); // Indicate that auth status check is in progress
    final result = await getCurrentUser(NoParams());
    result.when(
      (user) {
        if (user != null) {
          emit(AuthState.authenticated(user)); // User is authenticated
        } else {
          emit(AuthState.unauthenticated()); // No user found, unauthenticated
        }
      },
      (error) {
        emit(AuthState.unauthenticated()); // On error, treat as unauthenticated
      },
    );
  }

  //================== Error Message Functions =================== //
  //
  /// Helper method to get a user-friendly error message from a Failure instance
  String _getErrorMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message; // Show server-specific error
    } else if (failure is CacheFailure) {
      return failure.message; // Show cache-specific error
    }
    return 'An unexpected error occurred'; // Default error
  }

  //================== CR Validation Functions =================== //
  //
  /// Checks if a CR number is valid by fetching CR info.
  /// Returns true if valid, false otherwise.
  Future<bool> validateCrNumber(String crNumber) async {
    print('[CR Validation] Starting validation for CR number: $crNumber');
    try {
      print('[CR Validation] Calling getCrInfo API...');
      final crInfo = await getCrInfo(crNumber);
      print('[CR Validation] CR number is VALID. Got response: ${crInfo.name}');
      // Successful call means CR number is valid
      return true;
    } catch (e) {
      print('[CR Validation] CR number is INVALID. Error: $e');
      print('[CR Validation] Error type: ${e.runtimeType}');
      print('[CR Validation] Error details: ${e.toString()}');
      // Exception means CR number is invalid
      return false;
    }
  }

  //================== Sign Up Functions =================== //
  //
  /// Handles the sign-up flow.
  /// If role is 'Company', validates the CR number before proceeding.
  /// Emits loading, error, or OTP-sent/auth states as appropriate.
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

    // Validate CR number only for Company role
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
        // Send OTP after successful signup for email verification
        final otpResult = await resendOTP(ResendOTPParams(email: email));
        otpResult.when(
          (success) {
            print('[SignUp] OTP sent successfully');
            emit(AuthState.otpSent(email)); // Move to OTP verification state
          },
          (error) {
            // Move to verification state even if OTP sending fails,
            // user can resend OTP from that page
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
        emit(AuthState.error(_getErrorMessage(error))); // Show signup error
      },
    );
  }

  //================== Sign In Functions =================== //
  //
  /// Handles sign-in, emits either loading, authenticated, or error state
  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(AuthState.loading()); // Indicate login in progress
    final result = await login(LoginParams(email: email, password: password));

    result.when(
      (user) {
        emit(AuthState.authenticated(user, role: user.role)); // Login success
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error))); // Show login error
      },
    );
  }

  //================== Send OTP Functions =================== //
  //
  /// Sends a new OTP to the given email for verification, handles states
  Future<void> sendOTPToEmail(String email) async {
    emit(AuthState.loading());

    final result = await sendOTP(SendOTPParams(email: email));

    result.when(
      (success) {
        emit(AuthState.otpSent(email)); // OTP sent state
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error))); // Handle send OTP error
      },
    );
  }

  //================== Resend OTP Functions =================== //
  //
  /// Resends OTP to the user's email, emits state for success/error
  Future<void> resendOTPToEmail(String email) async {
    emit(AuthState.loading());

    final result = await resendOTP(ResendOTPParams(email: email));

    result.when(
      (success) {
        emit(AuthState.otpSent(email)); // OTP resent
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error))); // Resend failed
      },
    );
  }

  //================== Verify OTP Functions =================== //
  //
  /// Verifies the provided OTP code. Emits loading, authenticated, or error
  Future<void> verifyOTPCode({
    required String email,
    required String token,
  }) async {
    emit(AuthState.loading());

    final result = await verifyOTP(VerifyOTPParams(email: email, token: token));

    result.when(
      (user) {
        emit(AuthState.authenticated(user, role: user.role)); // OTP correct
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error))); // Wrong OTP, or error
      },
    );
  }

  //================== Password Reset Functions =================== //
  //
  /// Sends a password reset OTP to the provided email.
  /// Trims email, emits relevant state.
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

  //================== Verify Password Reset OTP Functions =================== //
  //
  /// Verifies the password reset OTP code. Emits either verified or error state.
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

  //================== Update Password Functions =================== //
  //
  /// Updates the user's password. If successful, reauthenticates and updates state.
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

  //================== Sign Out Functions =================== //
  //
  /// Signs the user out and emits either unauthenticated or error state.
  Future<void> signOutUser() async {
    emit(AuthState.loading());
    final result = await signOut(NoParams());
    result.when(
      (success) {
        emit(AuthState.unauthenticated()); // Sign out successful
      },
      (error) {
        emit(AuthState.error(_getErrorMessage(error))); // Sign out failed
      },
    );
  }
}
