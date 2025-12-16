import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/core/utils/validators.dart';
import 'package:graduation_project/core/widgets/app_text_field.dart';
import 'package:graduation_project/core/widgets/loading_button.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';

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
    return BlocBuilder<AuthCubit, AuthState>(
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
                isLoading: state is AuthLoading,
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
