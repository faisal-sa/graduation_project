import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/snacksoo.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OTPVerificationPage extends StatelessWidget {
  final String email;

  const OTPVerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Snacksoo.show(
            context,
            message: 'OTP verified successfully!',
            type: TopSnackBarType.success,
          );
          // Navigate based on user role
          final role = state.role?.toLowerCase() ?? '';
          if (role == 'company') {
            context.go('/company/onboarding-router');
          } else {
            // Individual users go to insights page
            context.go('/insights');
          }
        } else if (state.status == AuthStatus.error) {
          Snacksoo.show(
            context,
            message: state.message ?? 'An error occurred',
            type: TopSnackBarType.error,
          );
        } else if (state.status == AuthStatus.otpSent) {
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
            title: const Text('Verify OTP'),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            leading: IconButton(
              onPressed: () => context.pop(),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'We\'ve sent a verification code to\n$email',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
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
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12,

                              fontWeight: FontWeight.w300,
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
                                    context.read<AuthCubit>().verifyOTPCode(
                                      email: email,
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
