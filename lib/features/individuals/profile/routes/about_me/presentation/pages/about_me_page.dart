import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_cubit.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_state.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/widgets/save_bottom_bar.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/widgets/summary_input.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/widgets/video_picker_section.dart';
import 'package:graduation_project/features/individuals/shared/user/presentation/cubit/user_cubit.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'About Me',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: BlocListener<AboutMeCubit, AboutMeState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            serviceLocator.get<UserCubit>().updateAboutMe(
              summary: state.summary,
              videoUrl: state.existingVideoUrl,
            );

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
                content: Text('Failed to save profile. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              SummaryInput(),
              const SizedBox(height: 32),
              const Text(
                'Video Intro',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Introduce yourself to recruiters with a short video. It\'s a great way to stand out!',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              const VideoPickerSection(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SaveBottomBar(),
    );
  }
}
