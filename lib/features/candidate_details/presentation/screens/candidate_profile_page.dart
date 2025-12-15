import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/ai_analysis/presentation/screens/ai_analysis_screen.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/contact_section_widget.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/profile_header.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/profile_history_widget.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/profile_summary_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

import '../cubit/candidate_details_cubit.dart';
import '../cubit/candidate_details_state.dart';
import '../../domain/entities/candidate_profile_entity.dart';

class CandidateProfilePage extends StatelessWidget {
  final String candidateId;
  final String? targetJobTitle;

  const CandidateProfilePage({
    super.key,
    required this.candidateId,
    this.targetJobTitle,
  });

  Future<void> _launchCV(BuildContext context, String? url) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No CV attached for this candidate")),
      );
      return;
    }

    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not open CV: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyId = Supabase.instance.client.auth.currentUser?.id;

    if (companyId == null) {
      return const Scaffold(
        body: Center(child: Text("Please login as company")),
      );
    }

    return BlocProvider(
      create: (context) =>
          GetIt.I<CandidateProfileCubit>()..loadProfile(candidateId, companyId),
      child: BlocBuilder<CandidateProfileCubit, CandidateProfileState>(
        builder: (context, state) {
          bool currentBookmarkStatus = false;
          state.whenOrNull(
            loaded: (profile) => currentBookmarkStatus = profile.isBookmarked,
          );

          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) return;
              context.pop(currentBookmarkStatus);
            },
            child: Scaffold(
              backgroundColor: Colors.grey[50],
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    context.pop(currentBookmarkStatus);
                  },
                ),
                title: const Text(
                  "Candidate Profile",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  state.maybeWhen(
                    loaded: (profile) {
                      return Container(
                        margin: EdgeInsets.only(right: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            profile.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: profile.isBookmarked
                                ? Colors.purple
                                : Colors.grey,
                          ),
                          onPressed: () {
                            context
                                .read<CandidateProfileCubit>()
                                .toggleBookmark(profile.id, companyId);
                          },
                        ),
                      );
                    },
                    orElse: () => const SizedBox(),
                  ),
                ],
              ),
              bottomNavigationBar: state.maybeWhen(
                loaded: (profile) {
                  if (profile.isUnlocked && profile.cvUrl != null) {
                    return Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => _launchCV(context, profile.cvUrl),
                        icon: const Icon(Icons.download_rounded),
                        label: const Text("Download CV / Resume"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                orElse: () => const SizedBox.shrink(),
              ),
              body: BlocConsumer<CandidateProfileCubit, CandidateProfileState>(
                listener: (context, state) {
                  state.whenOrNull(
                    error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(msg), backgroundColor: Colors.red),
                    ),
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    unlocking: () => const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                    loaded: (profile) =>
                        _buildMainContent(context, profile, companyId),
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    CandidateProfileEntity profile,
    String companyId,
  ) {
    final fullName = "${profile.firstName} ${profile.lastName}";
    final skillsString = profile.skills.isNotEmpty
        ? profile.skills.join(", ")
        : "No skills listed";
    final comparisonJobTitle = targetJobTitle ?? profile.jobTitle;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeaderr(profile: profile),
          Gap(24.h),
          _buildSectionCard(
            title: "AI Analysis",
            icon: Icons.auto_awesome,
            iconColor: Colors.purple,
            child: AiScoreCard(
              candidateName: fullName,
              skills: skillsString,
              currentJobTitle: profile.jobTitle,
              targetJobTitle: comparisonJobTitle,
            ),
          ),
          Gap(20.h),
          _buildSectionCard(
            title: "Contact Information",
            icon: Icons.contact_page_outlined,
            iconColor: Colors.blue,
            child: ContactSectionWidget(profile: profile, companyId: companyId),
          ),
          Gap(20.h),
          _buildSectionCard(
            title: "About Candidate",
            icon: Icons.person_outline,
            iconColor: Colors.orange,
            child: ProfileSummaryWidget(profile: profile),
          ),
          Gap(20.h),
          _buildSectionCard(
            title: "Work History",
            icon: Icons.history,
            iconColor: Colors.green,
            child: ProfileHistoryWidget(profile: profile),
          ),
          Gap(40.h),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
              Gap(12.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Gap(16.h),
          child,
        ],
      ),
    );
  }
}
