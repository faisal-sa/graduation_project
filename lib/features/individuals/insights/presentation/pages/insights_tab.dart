import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Row(
                  children: [
                    Expanded(
                      child: isComplete
                          ? FeatureCard(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.handshake,
                                    color: Colors.pink,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "78%",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textMain,
                                    ),
                                  ),
                                  const Text(
                                    "Match Strength",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSub,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.pink.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Great fit!",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.pink.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.bolt,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: const Text(
                                          "New",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "AI Skill Check",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Text(
                                    "Validate top skills",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSub,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
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
                              unlockText: "Generate quiz based on experience.",
                            ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Text(
                  "Recent Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                if (isComplete)
                  _buildAnalyticsSection()
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
    return FeatureCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Performance",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [35, 55, 40, 70, 50, 90, 100].asMap().entries.map((
                entry,
              ) {
                final isLast = entry.key == 6;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: entry.value * 1.2,
                          decoration: BoxDecoration(
                            color: isLast
                                ? AppColors.bluePrimary
                                : AppColors.bluePrimary.withOpacity(0.2),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                .map(
                  (d) => Text(
                    d,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSub,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
