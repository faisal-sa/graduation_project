import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/individuals/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/individuals/profile/presentation/widgets/profile_completion_bar.dart';
import 'package:graduation_project/features/individuals/profile/presentation/widgets/profile_header.dart';
import 'package:graduation_project/features/individuals/profile/presentation/widgets/profile_menu_item.dart';


class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileNavigateTo) {
          context.push(state.route);
          debugPrint("Navigating to: ${state.route}");
        }
      },
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const ProfileHeader(),
              const SizedBox(height: 30),
              const ProfileCompletionBar(),
              const SizedBox(height: 30),

              ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Basic Information',
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.badge_outlined,
                title: 'About Me',
                onTap: () => context.read<ProfileCubit>().onAboutMeTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.work_outline,
                title: 'Work Experience',
                onTap: () =>
                    context.read<ProfileCubit>().onWorkExperienceTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.school_outlined,
                title: 'Education',
                onTap: () => context.read<ProfileCubit>().onEducationTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.school_outlined,
                title: 'Certifications',
                onTap: () =>
                    context.read<ProfileCubit>().onCertificationsTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.translate,
                title: 'Skills & Languages',
                onTap: () => context.read<ProfileCubit>().onSkillsTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.description_outlined,
                title: 'Job Preferences',
                onTap: () =>
                    context.read<ProfileCubit>().onJobPreferencesTapped(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
