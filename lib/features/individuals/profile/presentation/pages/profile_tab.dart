import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';
import 'package:graduation_project/features/shared/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              const _ProfileHeader(),
              const SizedBox(height: 30),
              const _ProfileCompletionBar(),
              const SizedBox(height: 30),

              ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Basic Information',
                subtitle: 'Add your name, location, and contact info',
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.badge_outlined,
                title: 'About Me',
                subtitle: 'Write a summary or add a video intro',
                onTap: () => context.read<ProfileCubit>().onAboutMeTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.work_outline,
                title: 'Work Experience',
                subtitle: 'Add your past jobs and internships',
                onTap: () =>
                    context.read<ProfileCubit>().onWorkExperienceTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.school_outlined,
                title: 'Education',
                subtitle: 'Add degrees',
                onTap: () => context.read<ProfileCubit>().onEducationTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.school_outlined,
                title: 'Certifications',
                subtitle: 'courses, and certificates',
                onTap: () =>
                    context.read<ProfileCubit>().onCertificationsTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.translate,
                title: 'Skills & Languages',
                subtitle: 'List your technical skills and languages',
                onTap: () => context.read<ProfileCubit>().onSkillsTapped(),
              ),
              ProfileMenuItem(
                icon: Icons.description_outlined,
                title: 'Job Preferences',
                subtitle: 'Set your target role and salary expectations',
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    // Helper function to handle the upload logic
    Future<void> _uploadAvatar(BuildContext context) async {
      final ImagePicker picker = ImagePicker();
      final SupabaseClient supabase = serviceLocator.get<SupabaseClient>();

      // 1. Pick Image
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600, // Compress image for better performance
        maxHeight: 600,
      );

      if (image == null) return; // User cancelled

      try {
        final userId = supabase.auth.currentUser!.id;
        final imageExtension = image.path.split('.').last;
        // Create a unique file path: userId/timestamp.jpg
        final fileName =
            '$userId/${DateTime.now().millisecondsSinceEpoch}.$imageExtension';

        // 2. Upload to Supabase Storage (Bucket name: 'avatars')
        await supabase.storage
            .from('avatars')
            .upload(
              fileName,
              File(image.path),
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ),
            );

        // 3. Get Public URL
        final String imageUrl = supabase.storage
            .from('avatars')
            .getPublicUrl(fileName);

        // 4. Update Database Profile
        await supabase
            .from('profiles')
            .update({
              'avatar_url': imageUrl,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId);

        // 5. Update Local State (UserCubit)
        // Assuming your UserCubit has an event or method to update the user object locally
        if (context.mounted) {
          // Option A: Trigger a reload of the profile
          // context.read<UserCubit>().loadProfile();

          // Option B: Update specific field (More efficient)
          context.read<UserCubit>().updateLocalAvatar(imageUrl);
        }
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Upload failed: $error')));
        }
      }
    }

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;

        // Logic to construct the full name
        final String fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'
            .trim();
        // Logic to construct the full name
        final bool hasName = fullName.isNotEmpty;

        // Logic for Job and Location
        final bool hasJob = user.jobTitle.isNotEmpty;
        final bool hasLocation = user.location.isNotEmpty;

        // Logic for Avatar Image Provider
        // We check if avatar_url exists, if so use NetworkImage, else null
        final ImageProvider? avatarImage =
            (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
            ? NetworkImage(user.avatarUrl!)
            : null;

        return Column(
          children: [
            // --- AVATAR SECTION ---
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: avatarImage,
                    // Only show the Person Icon if there is no image
                    child: avatarImage == null
                        ? const Icon(Icons.person, size: 60, color: Colors.grey)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _uploadAvatar(context), // Trigger the upload
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2563EB),
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- NAME SECTION ---
            if (fullName.isNotEmpty)
              Text(
                fullName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              )
            else
              // GUEST/EMPTY NAME STATE
              GestureDetector(
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF), // Blue-50
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFDBEAFE),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Add Your Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Color(0xFF2563EB),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),

            // --- JOB TITLE SECTION ---
            if (hasJob)
              Text(
                user.jobTitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              )
            else
              _EmptyStateChip(
                icon: Icons.work_outline,
                label: "Add Job Title",
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
              ),

            const SizedBox(height: 6),

            // --- LOCATION SECTION ---
            if (hasLocation)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    user.location,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              )
            else
              _EmptyStateChip(
                icon: Icons.location_on_outlined,
                label: "Add Location",
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
              ),
          ],
        );
      },
    );
  }
}

class _ProfileCompletionBar extends StatelessWidget {
  const _ProfileCompletionBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final double progress = state.profileCompletion;
        final String percentageText = "${(progress * 100).toInt()}%";

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile Completion",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  percentageText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF2563EB),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Complete your profile to get noticed by recruiters.",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ],
        );
      },
    );
  }
}

// --- Helpers (Kept as is) ---

class _EmptyStateChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _EmptyStateChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF), // Light Blue background
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFBFDBFE)), // Blue border
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF2563EB)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB), // Blue text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xFF2563EB), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.add_circle_outline, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
