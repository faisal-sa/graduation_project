import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_cubit.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_state.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/widgets/dashed_border_painter.dart';
import 'package:graduation_project/features/individuals/shared/user/presentation/cubit/user_cubit.dart';
import 'package:image_picker/image_picker.dart';

class VideoPickerSection extends StatelessWidget {
  const VideoPickerSection({super.key});

  Future<void> _pickVideo(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 2),
    );

    if (video != null && context.mounted) {
      context.read<AboutMeCubit>().videoSelected(video.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        bool hasPendingFile = state.videoPath != null;
        bool hasExistingUrl =
            state.existingVideoUrl != null &&
            state.existingVideoUrl!.isNotEmpty;

        if (hasPendingFile) {
          return _buildFilePreview(context, state.videoPath!);
        }

        if (hasExistingUrl) {
          return _buildExistingVideoPreview(context, state.existingVideoUrl!);
        }

        return GestureDetector(
          onTap: () => _pickVideo(context),
          child: CustomPaint(
            painter: DashedBorderPainter(
              color: Colors.grey[300]!,
              gap: 6,
              strokeWidth: 5,
            ),
            child: Container(
              height: 180,
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xFF3B82F6),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Add a Video Intro',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilePreview(BuildContext context, String path) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.video_file, size: 48, color: Colors.blue),
          const SizedBox(height: 8),
          const Text(
            "New video selected",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextButton.icon(
            onPressed: () => context.read<AboutMeCubit>().removeSelectedVideo(),
            icon: const Icon(Icons.close, color: Colors.red),
            label: const Text(
              "Cancel Upload",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExistingVideoPreview(BuildContext context, String url) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: NetworkImage(
            "https://placehold.co/600x400/000000/FFFFFF/png?text=Video+Preview",
          ),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              const Text(
                "Video Uploaded",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Delete Video?"),
                          content: const Text("This action cannot be undone."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await context
                                    .read<AboutMeCubit>()
                                    .deleteExistingVideo();
                                if (context.mounted) {
                                  serviceLocator
                                      .get<UserCubit>()
                                      .deleteUserVideo();
                                }
                              },
                             
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
