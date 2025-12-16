import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/core/utils/validators.dart';
import 'package:graduation_project/core/utils/snacksoo.dart';
import 'package:graduation_project/core/widgets/app_text_field.dart';
import 'package:graduation_project/core/widgets/loading_button.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';
import 'package:go_router/go_router.dart';

// ===============================================================
// LOGIN TAB
// ===============================================================
class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Snacksoo.show(
            context,
            message: 'Login successful!',
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
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 23),
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
              const SizedBox(height: 24),
              loadingBtn(
                text: 'Login',
                isLoading: state.status == AuthStatus.loading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthCubit>().signInUser(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => context.push('/reset-password'),
                  child: const Text(
                    'Forgot your password? Reset it',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
