import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/snacksoo.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Snacksoo.show(
            context,
            message: 'Password updated successfully!',
            type: TopSnackBarType.success,
          );
          Future.delayed(const Duration(seconds: 1)).then((_) {
            if (context.mounted) {
              context.go('/login');
            }
          });
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
                      TextFormField(
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'New Password',
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
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
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
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
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
                                  context.read<AuthCubit>().updateUserPassword(
                                    newPassword: newPasswordController.text,
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
                                'Update Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
