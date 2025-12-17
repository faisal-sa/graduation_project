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

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _email;
  bool _otpSent = false;

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.passwordResetEmailSent) {
          setState(() {
            _otpSent = true;
            _email = state.email;
          });
          Snacksoo.show(
            context,
            message: 'OTP sent! Check your inbox.',
            type: TopSnackBarType.success,
          );
        } else if (state.status == AuthStatus.passwordResetVerified) {
          context.push('/new-password');
        } else if (state.status == AuthStatus.error) {
          Snacksoo.show(
            context,
            message: state.message ?? 'An error occurred',
            type: TopSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.lock_reset,
                        size: 64,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _otpSent
                            ? 'We\'ve sent a verification code to\n${_email ?? ""}'
                            : 'Enter your email address and we\'ll send you an OTP to reset your password.',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      if (!_otpSent) ...[
                        AppTextField(
                          label: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 24),
                        loadingBtn(
                          text: 'Send OTP',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .sendPasswordResetOTPToEmail(
                                    email: emailController.text.trim(),
                                  );
                            }
                          },
                          isLoading: state.status == AuthStatus.loading,
                        ),
                      ] else ...[
                        AppTextField(
                          label: 'OTP Code',
                          controller: otpController,
                          hintText: 'Enter 6-digit code',

                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: Validators.validateOTP,
                        ),
                        const SizedBox(height: 24),
                        loadingBtn(
                          text: 'Verify OTP',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .verifyPasswordResetOTPCode(
                                    email:
                                        _email ?? emailController.text.trim(),
                                    token: otpController.text.trim(),
                                  );
                            }
                          },
                          isLoading: state.status == AuthStatus.loading,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: state.status == AuthStatus.loading
                              ? null
                              : () {
                                  setState(() {
                                    _otpSent = false;
                                    otpController.clear();
                                  });
                                },
                          child: const Text(
                            'Change Email',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ],
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
