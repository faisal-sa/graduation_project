import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FeatureCard extends StatelessWidget {
  final Widget child;
  // Removed onTap from here

  const FeatureCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Removed GestureDetector
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white, // Assuming AppColors.white
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
