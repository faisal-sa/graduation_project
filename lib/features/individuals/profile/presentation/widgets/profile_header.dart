import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/individuals/profile/presentation/pages/profile_tab.dart';
import 'package:graduation_project/features/individuals/profile/presentation/widgets/empty_state_chip.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';
import 'package:graduation_project/features/shared/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> uploadAvatar(BuildContext context) async {
      final ImagePicker picker = ImagePicker();
      final SupabaseClient supabase = serviceLocator.get<SupabaseClient>();

      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (image == null) return;

      try {
        final userId = supabase.auth.currentUser!.id;

        final String fileExtension = image.name.split('.').last;

        final fileName =
            '$userId/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

        final Uint8List imageBytes = await image.readAsBytes();

        await supabase.storage
            .from('avatars')
            .uploadBinary(
              fileName,
              imageBytes,
              fileOptions: FileOptions(
                cacheControl: '3600',
                upsert: true,

                contentType: image.mimeType ?? 'image/$fileExtension',
              ),
            );

        final String imageUrl = supabase.storage
            .from('avatars')
            .getPublicUrl(fileName);

        await supabase
            .from('profiles')
            .update({
              'avatar_url': imageUrl,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId);

        if (context.mounted) {
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
        final String fullName = '${user.firstName} ${user.lastName}'
            .trim();
        final bool hasJob = user.jobTitle.isNotEmpty;
        final bool hasLocation = user.location.isNotEmpty;

        final ImageProvider? avatarImage =
            (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
            ? NetworkImage(user.avatarUrl!)
            : null;

        return Column(
          children: [
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
                    child: avatarImage == null
                        ? const Icon(Icons.person, size: 60, color: Colors.grey)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => uploadAvatar(context),
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
            // ... (Rest of UI)
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
              GestureDetector(
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
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
              EmptyStateChip(
                icon: Icons.work_outline,
                label: "Add Job Title",
                onTap: () => context.read<ProfileCubit>().onBasicInfoTapped(),
              ),

            const SizedBox(height: 6),

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
              EmptyStateChip(
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
