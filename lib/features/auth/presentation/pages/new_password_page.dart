// ============================================================================
//                           NEW PASSWORD PAGE
// ============================================================================
// This page allows users to set a new password after successfully verifying
// their password reset OTP code.
//
// FLOW:
// 1. User enters new password and confirms it
// 2. Form validates both fields (password length, matching passwords)
// 3. On submit, calls AuthCubit.updateUserPassword()
// 4. On success, shows success message and redirects to login page
// 5. On error, displays error message via snackbar
//
// VALIDATION:
// - New password must be at least 6 characters
// - Confirm password must match the new password
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/snacksoo.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers for password input fields
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      // Listens to auth state changes and handles navigation/feedback
      listener: (context, state) {
        // Password update successful - show success and redirect to login
        if (state.status == AuthStatus.authenticated) {
          Snacksoo.show(
            context,
            message: 'Password updated successfully!',
            type: TopSnackBarType.success,
          );
          // Small delay before navigation to let user see success message
          Future.delayed(const Duration(seconds: 1)).then((_) {
            if (context.mounted) {
              context.go('/login');
            }
          });
        } else if (state.status == AuthStatus.error) {
          // Show error message if password update fails
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
            title: const Text('New Password'),
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
                        Icons.lock_outline,
                        size: 64,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Create New Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please enter your new password',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // New password input field
                      AppTextField(
                        label: 'New Password',
                        controller: newPasswordController,
                        obscure: true, // Hide password characters
                        validator: Validators.validatePassword,
                      ),
                      const SizedBox(height: 16),
                      // Confirm password input field
                      AppTextField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        obscure: true, // Hide password characters
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                              value,
                              newPasswordController.text,
                            ),
                      ),
                      const SizedBox(height: 24),
                      // Submit button to update password
                      loadingBtn(
                        text: 'Update Password',
                        onPressed: () {
                          // Validate form before submitting
                          if (formKey.currentState!.validate()) {
                            // Call cubit to update password
                            context.read<AuthCubit>().updateUserPassword(
                              newPassword: newPasswordController.text,
                            );
                          }
                        },
                        isLoading: state.status == AuthStatus.loading,
                      ),
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
