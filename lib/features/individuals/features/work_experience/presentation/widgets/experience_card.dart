import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:intl/intl.dart';

class ExperienceCard extends StatelessWidget {
  final WorkExperience experience;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onDelete,
    required this.onEdit,
  });


  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('MMM yyyy');
    final dateStr =
        "${fmt.format(experience.startDate)} - ${experience.isCurrentlyWorking ? 'Present' : (experience.endDate != null ? fmt.format(experience.endDate!) : '')}";

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.jobTitle,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${experience.companyName} • ${experience.employmentType}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateStr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              // Actions Row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    constraints: const BoxConstraints(), // Reduces padding
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.blue[400],
                      size: 20.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.only(left: 8.w),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red[300],
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (experience.responsibilities.isNotEmpty) ...[
            Divider(height: 24.h, color: Colors.grey[100]),
            ...experience.responsibilities.map(
              (r) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Icon(
                        Icons.circle,
                        size: 5.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        r,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
