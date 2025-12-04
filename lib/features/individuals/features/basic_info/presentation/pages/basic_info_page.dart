import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduation_project/app/widgets/saving_button.dart';
import 'package:graduation_project/features/individuals/features/basic_info/presentation/cubit/basic_info_cubit.dart';
import 'package:graduation_project/app/widgets/custom_text_field.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';

class BasicInfoPage extends HookWidget {
  const BasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserCubit>().state.user;

    final firstNameCtrl = useTextEditingController(text: currentUser.firstName);
    final lastNameCtrl = useTextEditingController(text: currentUser.lastName);
    final jobTitleCtrl = useTextEditingController(text: currentUser.jobTitle);
    final locationCtrl = useTextEditingController(text: currentUser.location);
    final phoneCtrl = useTextEditingController(text: currentUser.phoneNumber);
    final emailCtrl = useTextEditingController(text: currentUser.email);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Basic Information',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocListener<BasicInfoCubit, BasicInfoState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            final currentUser = context.read<UserCubit>().state.user;
            final updatedUser = currentUser.copyWith(
              firstName: firstNameCtrl.text,
              lastName: lastNameCtrl.text,
              jobTitle: jobTitleCtrl.text,
              phoneNumber: phoneCtrl.text,
              email: emailCtrl.text,
              location: locationCtrl.text,
            );

            context.read<UserCubit>().updateUser(updatedUser);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile Saved!'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.of(context).pop();
          } else if (state.status == FormStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to save'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'First Name',
                      hint: 'John',
                      controller: firstNameCtrl,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'Last Name',
                      hint: 'Doe',
                      controller: lastNameCtrl,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Job Title',
                hint: 'Software Engineer',
                controller: jobTitleCtrl,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Location',
                hint: 'New York, USA',
                controller: locationCtrl,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Phone',
                hint: '1234567890',
                controller: phoneCtrl,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Email',
                hint: 'email@example.com',
                controller: emailCtrl,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<BasicInfoCubit, BasicInfoState>(
        builder: (context, state) {
          return SavingButton(
            text: 'Save',
            isLoading: state.status == FormStatus.loading,
            onPressed: () {
              context.read<BasicInfoCubit>().saveForm(
                firstName: firstNameCtrl.text,
                lastName: lastNameCtrl.text,
                jobTitle: jobTitleCtrl.text,
                phoneNumber: phoneCtrl.text,
                email: emailCtrl.text,
                location: locationCtrl.text,
              );
            },
          );
        },
      ),
    );
  }
}
