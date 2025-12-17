import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/snacksoo.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// OTPVerificationPage is responsible for verifying the user's OTP code.
/// It displays a form for OTP entry and provides feedback through Snacksoo notifications.
/// Navigation is handled based on authentication success and user role.
class OTPVerificationPage extends StatelessWidget {
  final String email;

  /// [email] is the user's email address where the OTP was sent.
  const OTPVerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Controller for the OTP text field.
    final otpController = TextEditingController();
    // Key for validating the form.
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // Success: User authenticated with OTP.
        if (state.status == AuthStatus.authenticated) {
          Snacksoo.show(
            context,
            message: 'OTP verified successfully!',
            type: TopSnackBarType.success,
          );
          // Navigate based on user role.
          final role = state.role?.toLowerCase() ?? '';
          if (role == 'company') {
            // If the user is a company, go to onboarding.
            context.go('/company/onboarding-router');
          } else {
            // Individuals go to the insights page.
            context.go('/insights');
          }
        }
        // Error occurred during OTP verification.
        else if (state.status == AuthStatus.error) {
          Snacksoo.show(
            context,
            message: state.message ?? 'An error occurred',
            type: TopSnackBarType.error,
          );
        }
        // OTP was resent successfully.
        else if (state.status == AuthStatus.otpSent) {
          Snacksoo.show(
            context,
            message: 'OTP has been resent to your email',
            type: TopSnackBarType.success,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => context.go('/auth'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // User verification icon.
                        Icon(Icons.verified_user, size: 64, color: Colors.blue),
                        SizedBox(height: 13),
                        // Title text.
                        const Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Instruction displaying the email to which OTP was sent.
                        Text(
                          'We\'ve sent a verification code to\n$email',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        // OTP entry field with number formatting.
                        AppTextField(
                          label: 'OTP Code',
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 6,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: 'Enter 6-digit code',
                          validator: Validators.validateOTP,
                        ),
                        const SizedBox(height: 24),
                        // Submit button for verifying the OTP.
                        loadingBtn(
                          text: 'Verify OTP',
                          isLoading: state.status == AuthStatus.loading,
                          onPressed: () {
                            // Validate form and attempt OTP verification.
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().verifyOTPCode(
                                email: email,
                                token: otpController.text.trim(),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Button for resending the OTP to the user's email.
                        TextButton(
                          onPressed: state.status == AuthStatus.loading
                              ? null
                              : () {
                                  context.read<AuthCubit>().resendOTPToEmail(
                                    email,
                                  );
                                },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
