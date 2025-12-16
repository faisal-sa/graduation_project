import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/snacksoo.dart';
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
            title: const Text('Reset Password'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
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
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: state.status == AuthStatus.loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<AuthCubit>()
                                        .sendPasswordResetOTPToEmail(
                                          email: emailController.text.trim(),
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state.status == AuthStatus.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ] else ...[
                        TextFormField(
                          controller: otpController,
                          decoration: const InputDecoration(
                            labelText: 'OTP Code',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: 'Enter 6-digit code',
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 6,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter OTP code';
                            }
                            if (value.length != 6) {
                              return 'OTP must be 6 digits';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: state.status == AuthStatus.loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<AuthCubit>()
                                        .verifyPasswordResetOTPCode(
                                          email:
                                              _email ??
                                              emailController.text.trim(),
                                          token: otpController.text.trim(),
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state.status == AuthStatus.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Verify OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
