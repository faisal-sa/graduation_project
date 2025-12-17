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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        backgroundColor: Color(0xfff1f5f9),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/insights'),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
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
                  subtitle: "Manage personal details and contact info",
                  onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
                ),
                ProfileMenuItem(
                  icon: Icons.badge_outlined,
                  title: 'About Me',
                  subtitle: "Professional summary and brief video",

                  onTap: () => context.read<ProfileCubit>().onAboutMeTapped(),
                ),
                ProfileMenuItem(
                  icon: Icons.work_outline,
                  title: 'Work Experience',
                  subtitle: "Job history, roles, and achievements",

                  onTap: () =>
                      context.read<ProfileCubit>().onWorkExperienceTapped(),
                ),
                ProfileMenuItem(
                  icon: Icons.school_outlined,
                  title: 'Education',
                  subtitle: "Degrees, institutions, and graduation dates",

                  onTap: () => context.read<ProfileCubit>().onEducationTapped(),
                ),
                ProfileMenuItem(
                  icon: Icons.school_outlined,
                  title: 'Certifications',
                  subtitle: "Licenses, workshops, and credentials",

                  onTap: () =>
                      context.read<ProfileCubit>().onCertificationsTapped(),
                ),
                ProfileMenuItem(
                  icon: Icons.translate,
                  title: 'Skills & Languages',
                  subtitle: "Technical skills and language proficiency",

                  onTap: () => context.read<ProfileCubit>().onSkillsTapped(),
                ),
                ProfileMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Job Preferences',
                  subtitle: "Desired roles, salary, and work type",

                  onTap: () =>
                      context.read<ProfileCubit>().onJobPreferencesTapped(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
