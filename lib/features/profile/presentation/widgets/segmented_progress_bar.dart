import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SegmentedProgressBar extends StatelessWidget {
  final int totalSegment;
  final double progress;
  const SegmentedProgressBar({
    super.key,
    this.totalSegment = 3,
    this.progress = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSegment, (index) {
        final isFilled = index < (progress * totalSegment);

        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 10.h,
            decoration: BoxDecoration(
              color: isFilled ? Color(0xff135bec) : Color(0xffe2e8f0),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}
