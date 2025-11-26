import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_cubit.dart';
import 'package:graduation_project/features/individuals/features/about_me/presentation/cubit/about_me_state.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                content: Text('Failed to save'),
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

              const SizedBox(height: 60), // Space for bottom bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _SaveBottomBar(),
    );
  }
}

class _SummaryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<AboutMeCubit>().state;

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
          hintText:
              'Write a brief summary about yourself, your experience, and your career goals.',
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        // Logic to show selected video preview could go here
        // For now, showing the add button as per design
        return GestureDetector(
          onTap: () {
            // Trigger File Picker logic -> call context.read<AboutMeCubit>().videoSelected(path)
          },
          child: CustomPaint(
            painter: _DashedBorderPainter(color: Colors.grey[300]!, gap: 6),
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
                      fontSize: 14,
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
    this.strokeWidth = 1.0,
    this.gap = 5.0,
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
