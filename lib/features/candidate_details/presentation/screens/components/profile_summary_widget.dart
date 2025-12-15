import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:graduation_project/core/simple_video_player.dart';
import 'package:graduation_project/features/candidate_details/domain/entities/candidate_profile_entity.dart';

class ProfileSummaryWidget extends StatelessWidget {
  final CandidateProfileEntity profile;

  const ProfileSummaryWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (profile.introVideoUrl != null &&
            profile.introVideoUrl!.isNotEmpty) ...[
          InlineVideoPlayer(videoUrl: profile.introVideoUrl!),
          Gap(20.h),
        ],

        if (profile.aboutMe != null && profile.aboutMe!.isNotEmpty) ...[
          _buildSectionTitle("About Me"),
          Gap(8.h),
          Text(
            profile.aboutMe!,
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
              fontSize: 14.sp,
            ),
          ),
          Gap(20.h),
        ],

        // 3. تفضيلات العمل
        _buildSectionTitle("Work Preferences"),
        Gap(10.h),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (profile.canStartImmediately)
              _buildTag(Icons.flash_on, "Starts Immediately", Colors.orange),
            if (profile.canRelocate)
              _buildTag(
                Icons.flight_takeoff,
                "Willing to Relocate",
                Colors.blue,
              ),
            if (profile.currentWorkStatus != null)
              _buildTag(
                Icons.info_outline,
                profile.currentWorkStatus!,
                Colors.purple,
              ),
            ...profile.workModes.map(
              (m) => _buildTag(Icons.work, m, Colors.teal),
            ),
            ...profile.employmentTypes.map(
              (t) => _buildTag(Icons.schedule, t, Colors.indigo),
            ),
          ],
        ),
        Gap(20.h),

        // 4. اللغات
        if (profile.languages.isNotEmpty) ...[
          _buildSectionTitle("Languages"),
          Gap(8.h),
          Wrap(
            spacing: 8,
            children: profile.languages
                .map((l) => Chip(label: Text(l)))
                .toList(),
          ),
          Gap(20.h),
        ],

        // 5. المهارات
        if (profile.skills.isNotEmpty) ...[
          _buildSectionTitle("Skills"),
          Gap(8.h),
          Wrap(
            spacing: 8,
            children: profile.skills
                .map(
                  (s) =>
                      Chip(label: Text(s), backgroundColor: Colors.grey[200]),
                )
                .toList(),
          ),
          Gap(20.h),
        ],

        // 6. الراتب
        if (profile.minSalary != null || profile.maxSalary != null) ...[
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green),
                Gap(8.w),
                Text(
                  "Salary Expectation: ${profile.minSalary ?? 0} - ${profile.maxSalary ?? 'Any'} ${profile.salaryCurrency ?? 'USD'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTag(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: color),
          Gap(6.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
