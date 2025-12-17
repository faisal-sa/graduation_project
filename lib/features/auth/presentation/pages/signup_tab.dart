import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/core/utils/validators.dart';
import 'package:graduation_project/core/utils/snacksoo.dart';
import 'package:graduation_project/core/widgets/app_text_field.dart';
import 'package:graduation_project/core/widgets/loading_button.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';
import 'package:graduation_project/features/auth/presentation/pages/role_chip.dart';
import 'package:go_router/go_router.dart';

// ===============================================================
// SIGNUP TAB
// ===============================================================
class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  String? _selectedRole = 'individual';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final crNumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    crNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          Snacksoo.show(
            context,
            message: 'OTP sent to ${state.email}',
            type: TopSnackBarType.success,
          );
          context.push('/otp-verification', extra: state.email);
        } else if (state.status == AuthStatus.error) {
          Snacksoo.show(
            context,
            message: state.message ?? 'An error occurred',
            type: TopSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoleChip(
                      label: 'Individual',
                      icon: Icons.person_outline,
                      value: 'individual',
                      selectedRole: _selectedRole ?? 'individual',
                      onSelected: (role) =>
                          setState(() => _selectedRole = role),
                    ),
                    RoleChip(
                      label: 'Company',
                      icon: Icons.business_outlined,
                      value: 'company',
                      selectedRole: _selectedRole ?? 'individual',
                      onSelected: (role) =>
                          setState(() => _selectedRole = role),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                AppTextField(
                  label: 'Email',
                  controller: emailController,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Password',
                  obscure: true,
                  controller: passwordController,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Confirm Password',
                  obscure: true,
                  controller: confirmPasswordController,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                ),

                // Show CR number field only when Company is selected
                if (_selectedRole == 'company') ...[
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'CR number',
                    controller: crNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CR number';
                      }
                      return null;
                    },
                  ),
                ],

                const SizedBox(height: 16),

                // ===== ROLE CHIP SELECTION =====
                const SizedBox(height: 24),
                loadingBtn(
                  text: 'Create Account',
                  isLoading: state.status == AuthStatus.loading,
                  onPressed: () {
                    print('[UI] Signup button pressed');
                    if (formKey.currentState!.validate()) {
                      print('[UI] Form validation passed');
                      print('[UI] Calling signUpUser...');
                      context.read<AuthCubit>().signUpUser(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        role: _selectedRole == 'company'
                            ? 'Company'
                            : 'Individual',
                        crNumber: _selectedRole == 'company'
                            ? crNumberController.text
                            : null,
                      );
                    } else {
                      print('[UI] Form validation failed');
                    }
                  },
                ),

                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'By signing up you agree to our terms',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
