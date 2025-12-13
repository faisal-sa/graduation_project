import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/core/usecasesAbstract/no_params.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/individuals/engagement/presentation/widgets/engagement_section.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/feature_card.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/insights_app_bar.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/locked_feature_card.dart';
import 'package:graduation_project/features/individuals/shared/user/presentation/cubit/user_cubit.dart';
import 'package:graduation_project/features/individuals/shared/user/presentation/cubit/user_state.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InsightsAppBar(),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.resumeError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.resumeError!,
                  style: TextStyle(fontSize: 14.sp),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final completionRatio = state.profileCompletion;
            final completionPercent = (completionRatio * 100).toInt();
            final isComplete = completionRatio >= 0.8;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeCard(
                    userState: state,
                    isComplete: isComplete,
                    completionPercent: completionPercent,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Your Insights",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  InsightsFeatureGrid(isComplete: isComplete),
                  SizedBox(height: 24.h),
                  EngagementSection(isProfileComplete: isComplete),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Welcome Card (Main Container)
// -----------------------------------------------------------------------------
class WelcomeCard extends StatelessWidget {
  final UserState userState;
  final bool isComplete;
  final int completionPercent;

  const WelcomeCard({
    super.key,
    required this.userState,
    required this.isComplete,
    required this.completionPercent,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = userState.user.firstName.isNotEmpty
        ? userState.user.firstName
        : "User";

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColors.bluePrimary,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.bluePrimary.withAlpha(77),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isComplete
                ? "Welcome back, $displayName! 👋"
                : "Welcome to FINDMinds! 👋",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            isComplete
                ? "Your profile is active and ready to match."
                : "Let's get your profile ready for top companies.",
            style: TextStyle(color: Colors.blue.shade100, fontSize: 14.sp),
          ),
          SizedBox(height: 24.h),

          _ProfileStrengthIndicator(
            progressPercent: completionPercent,
            completionRatio: userState.profileCompletion,
          ),

          if (!isComplete) ...[
            SizedBox(height: 24.h),
            Text(
              "NEXT STEPS",
              style: TextStyle(
                color: Colors.blue.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 12.h),
            _ResumeUploadButton(isLoading: userState.isResumeLoading),
          ],
        ],
      ),
    );
  }
}

class _ProfileStrengthIndicator extends StatelessWidget {
  final int progressPercent;
  final double completionRatio;

  const _ProfileStrengthIndicator({
    required this.progressPercent,
    required this.completionRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.blueDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile Strength",
                style: TextStyle(
                  color: Colors.blue.shade100,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$progressPercent% Complete",
                style: TextStyle(
                  color: Colors.blue.shade100,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Stack(
            children: [
              Container(
                height: 8.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.blueDark,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOutExpo,
                height: 8.h,
                width:
                    MediaQuery.of(context).size.width * completionRatio,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResumeUploadButton extends StatelessWidget {
  final bool isLoading;

  const _ResumeUploadButton({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading
            ? null
            : () {
                context.read<UserCubit>().uploadAndExtractResume();
              },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: CircularProgressIndicator(strokeWidth: 2.w),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Analyzing PDF...",
                      style: TextStyle(
                        color: AppColors.textMain,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: const BoxDecoration(
                        color: AppColors.blueLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.upload_file,
                        color: AppColors.bluePrimary,
                        size: 20.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Resume",
                            style: TextStyle(
                              color: AppColors.textMain,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            "Auto-fill 80% of profile",
                            style: TextStyle(
                              color: AppColors.textSub,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bluePrimary,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 10.r,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "+100%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class InsightsFeatureGrid extends StatelessWidget {
  final bool isComplete;

  const InsightsFeatureGrid({super.key, required this.isComplete});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: isComplete
                ? FeatureCard(
                    // onTap moved to child
                    child: _FeatureCardContent(
                      icon: Icons.handshake,
                      iconColor: Colors.pink,
                      title: "Match Strength",
                      subtitle: "Check job fit",
                      actionText: "View Score",
                      // Pass the navigation logic here
                      onTap: () => context.go('/insights/match-strength'),
                    ),
                  )
                : const LockedFeatureCard(
                    icon: Icons.track_changes,
                    title: "Match Strength",
                    unlockText: "Complete profile to see scores.",
                  ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: isComplete
                ? FeatureCard(
                    // onTap moved to child
                    child: _FeatureCardContent(
                      icon: Icons.bolt,
                      iconColor: Colors.amber,
                      title: "AI Skill Check",
                      subtitle: "Validate top skills",
                      actionText: "Start Quiz",
                      // Pass the navigation logic here
                      onTap: () => context.go('/insights/ai-skill-check'),
                    ),
                  )
                : const LockedFeatureCard(
                    icon: Icons.bolt,
                    title: "AI Quiz",
                    unlockText: "Generate quiz based on experience.",
                  ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCardContent extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String actionText;
  final VoidCallback? onTap; // Added onTap here

  const _FeatureCardContent({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // 1. Align everything in the column to the center
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(icon, color: iconColor, size: 32.r),
        ),
        SizedBox(height: 12.h),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center internal column
          children: [
            Text(
              title,
              textAlign: TextAlign.center, // Center text alignment
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              textAlign: TextAlign.center, // Center text alignment
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey,
              ), // Assuming AppColors.textSub
            ),
          ],
        ),
        const Spacer(),
        SizedBox(height: 12.h),
        
        // 2. Wrap specifically the blue text row in an InkWell/GestureDetector
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Shrink row to fit text
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the row content
              children: [
                Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xff225ae3), // Assuming AppColors.bluePrimary
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward,
                  size: 14.r,
                  color: Color(0xff225ae3), // Assuming AppColors.bluePrimary
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
