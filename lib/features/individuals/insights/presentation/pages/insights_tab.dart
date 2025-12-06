import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/feature_card.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/locked_feature_card.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';
import 'package:graduation_project/features/shared/user_state.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.resumeError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.resumeError!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final userEntity = state.user;
          final completionRatio = state.profileCompletion;
          final completionPercent = (completionRatio * 100).toInt();
          final isComplete = completionRatio >= 0.8;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeCard(
                  context,
                  state,
                  isComplete,
                  completionPercent,
                ),
                const SizedBox(height: 24),

                const Text(
                  "Your Insights",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 140.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: isComplete
                            ? FeatureCard(
                                onTap: () {
                                  context.go('/insights/match-strength');
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.handshake,
                                        color: Colors.pink,
                                        size: 32.r,
                                      ),
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Match Strength",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Check job fit",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSub,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "View Score",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.bluePrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 14,
                                          color: AppColors.bluePrimary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const LockedFeatureCard(
                                icon: Icons.track_changes,
                                title: "Match Strength",
                                unlockText: "Complete profile to see scores.",
                              ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: isComplete
                            ? FeatureCard(
                                onTap: () {
                                  context.go('/insights/ai-skill-check');
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.bolt,
                                        color: Colors.amber,
                                        size: 32.r,
                                      ),
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "AI Skill Check",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Validate top skills",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSub,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "Start Quiz",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.bluePrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 14,
                                          color: AppColors.bluePrimary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const LockedFeatureCard(
                                icon: Icons.bolt,
                                title: "AI Quiz",
                                unlockText:
                                    "Generate quiz based on experience.",
                              ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  "Recent Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                if (isComplete)
                  Column(
                    children: [
                      _buildAnalyticsSection(),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Profile Traffic",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Icon(
                                  Icons.bar_chart,
                                  color: AppColors.bluePrimary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Visual placeholder for a Graph
                            SizedBox(
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(7, (index) {
                                  // Generate random heights for a fake bar chart look
                                  final height = [
                                    40.0,
                                    60.0,
                                    30.0,
                                    80.0,
                                    50.0,
                                    90.0,
                                    65.0,
                                  ][index];
                                  return Container(
                                    width: 30, // Adjust based on screen width
                                    height: height,
                                    decoration: BoxDecoration(
                                      color: index == 5
                                          ? AppColors.bluePrimary
                                          : Colors
                                                .grey
                                                .shade200, // Highlight one bar
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mon",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Tue",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Wed",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Thu",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Fri",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Sat",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Sun",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  
                else
                  const LockedFeatureCard(
                    icon: Icons.trending_up,
                    title: "Advanced Analytics",
                    unlockText: "Upload resume to track engagement.",
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeCard(
    BuildContext context,
    UserState state,
    bool isComplete,
    int progressPercent,
  ) {
    final displayName = state.user.firstName.isNotEmpty
        ? state.user.firstName
        : "User";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.bluePrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.bluePrimary.withAlpha(77),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isComplete
                ? "Your profile is active and ready to match."
                : "Let's get your profile ready for top companies.",
            style: TextStyle(color: Colors.blue.shade100, fontSize: 14),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.blueDark.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "$progressPercent% Complete",
                      style: TextStyle(
                        color: Colors.blue.shade100,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.blueDark,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOutExpo,
                      height: 8,
                      width:
                          MediaQuery.of(context).size.width *
                          state.profileCompletion *
                          0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (!isComplete) ...[
            const SizedBox(height: 24),
            Text(
              "NEXT STEPS",
              style: TextStyle(
                color: Colors.blue.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            // 2. Updated Upload Section
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: state.isResumeLoading
                    ? null // Disable tap while loading
                    : () {
                        context.read<UserCubit>().uploadAndExtractResume();
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: state.isResumeLoading
                      // 3. Loading State UI
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Analyzing PDF...",
                              style: TextStyle(
                                color: AppColors.textMain,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      // Normal UI
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.blueLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.upload_file,
                                color: AppColors.bluePrimary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Upload Resume",
                                    style: TextStyle(
                                      color: AppColors.textMain,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Auto-fill 80% of profile",
                                    style: TextStyle(
                                      color: AppColors.textSub,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.bluePrimary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "+100%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
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
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Row(
      children: [
        // Card 1: Appeared in Searches
        Expanded(
          child: FeatureCard(
            child: _buildStatContent(
              label: "Appeared in Searches",
              count: "342", // Replace with real data
              icon: Icons.person_search_rounded,
            ),
          ),
        ),
        const SizedBox(width: 16), // Spacing between the two cards
        // Card 2: Profile Views
        Expanded(
          child: FeatureCard(
            child: _buildStatContent(
              label: "Profile Views",
              count: "86", // Replace with real data
              icon: Icons.visibility_rounded,
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget to keep the internals of the two cards identical
  Widget _buildStatContent({
    required String label,
    required String count,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon with a light background circle
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.bluePrimary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.bluePrimary, size: 24,
          ),
        ),
        const SizedBox(height: 20),
        // The Big Number
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSub,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
