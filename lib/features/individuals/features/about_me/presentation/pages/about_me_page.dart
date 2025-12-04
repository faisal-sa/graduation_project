import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_cubit.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_state.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';
import 'package:image_picker/image_picker.dart';

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
            context.read<UserCubit>().updateAboutMe(
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
              _SummaryInput(),
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
              const _VideoPickerSection(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _SaveBottomBar(),
    );
  }
}

// ... _SummaryInput remains the same ...
class _SummaryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ideally use BlocBuilder here or in parent to prevent full rebuilds
    final state = context.select((AboutMeCubit c) => c.state);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        initialValue: state.summary,
        maxLines: 10,
        maxLength: 2000,
        onChanged: (val) => context.read<AboutMeCubit>().summaryChanged(val),
        style: const TextStyle(color: Color(0xFF334155), fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Write a brief summary...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
          counterStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class _VideoPickerSection extends StatelessWidget {
  const _VideoPickerSection();

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
            painter: _DashedBorderPainter(
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
                  // REPLACE BUTTON
                  ElevatedButton.icon(
                    onPressed: () => _pickVideo(context),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text("Replace"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // DELETE BUTTON
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
                              onPressed: () {
                                Navigator.pop(context);
                                context
                                    .read<AboutMeCubit>()
                                    .deleteExistingVideo();
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

class _SaveBottomBar extends StatelessWidget {
  const _SaveBottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: BlocBuilder<AboutMeCubit, AboutMeState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: state.status == FormStatus.loading
                  ? null
                  : () => context.read<AboutMeCubit>().saveForm(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: state.status == FormStatus.loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedBorderPainter({
    required this.color,
    this.gap = 5.0,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final Path dashedPath = _dashPath(path, width: 8, space: gap);
    canvas.drawPath(dashedPath, paint);
  }

  Path _dashPath(Path source, {required double width, required double space}) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dest.addPath(
          metric.extractPath(distance, distance + width),
          Offset.zero,
        );
        distance += width + space;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) => false;
}
