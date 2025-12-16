import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/core/utils/validators.dart';
import 'package:graduation_project/core/widgets/app_text_field.dart';
import 'package:graduation_project/core/widgets/loading_button.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';

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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                RoleDropdown(
                  selectedRole: _selectedRole,
                  onRoleChanged: (role) {
                    setState(() {
                      _selectedRole = role;
                    });
                  },
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
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signUpUser(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        role: _selectedRole == 'company'
                            ? 'Company'
                            : 'Individual',
                      );
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

// ===============================================================
// ROLE DROPDOWN (CHOICE CHIP)
// ===============================================================
class RoleDropdown extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String?> onRoleChanged;

  const RoleDropdown({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        ChoiceChip(
          avatar: Icon(
            Icons.person_outline,
            size: 20,
            color: selectedRole == 'individual' ? Colors.blue : Colors.grey,
          ),
          label: const Text('Individual'),
          selected: selectedRole == 'individual',
          onSelected: (selected) {
            onRoleChanged(selected ? 'individual' : null);
          },
          selectedColor: Colors.blue.withAlpha(20),
          checkmarkColor: Colors.blue,
          labelStyle: TextStyle(
            color: selectedRole == 'individual' ? Colors.blue : Colors.grey,
            fontWeight: selectedRole == 'individual'
                ? FontWeight.bold
                : FontWeight.normal,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: selectedRole == 'individual'
                  ? Colors.blue
                  : Colors.grey.withAlpha(30),
            ),
          ),
        ),
        ChoiceChip(
          avatar: Icon(
            Icons.business_outlined,
            size: 20,
            color: selectedRole == 'company' ? Colors.blue : Colors.grey,
          ),
          label: const Text('Company'),
          selected: selectedRole == 'company',
          onSelected: (selected) {
            onRoleChanged(selected ? 'company' : null);
          },
          selectedColor: Colors.blue.withAlpha(20),
          checkmarkColor: Colors.blue,
          labelStyle: TextStyle(
            color: selectedRole == 'company' ? Colors.blue : Colors.grey,
            fontWeight: selectedRole == 'company'
                ? FontWeight.bold
                : FontWeight.normal,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: selectedRole == 'company'
                  ? Colors.blue
                  : Colors.grey.withAlpha(30),
            ),
          ),
        ),
      ],
    );
  }
}
