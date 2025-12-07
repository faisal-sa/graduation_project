import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/utils/log_profile_view.dart';
import 'package:toastification/toastification.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import '../../../domain/entities/candidate_entity.dart';

class CandidateResultsPage extends StatelessWidget {
  const CandidateResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final primaryColor = Theme.of(context).primaryColor;
    const backgroundColor = Color(0xFFF8F9FD);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CandidateBookmarkedSuccess) {
            toastification.show(
              context: context,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              title: const Text('Candidate Saved'),
              description: const Text('You can find them in your bookmarks.'),
              autoCloseDuration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,
            );
          }
          // Handle Error State in Listener
          if (state is CompanyError) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              title: const Text('Search Failed'),
              description: Text(state.message),
              autoCloseDuration: const Duration(seconds: 4),
              alignment: Alignment.topCenter,
            );
          }
        },
        builder: (context, state) {
          // Handle Loading
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle Results or Error
          if (state is CandidateResults) {
            final candidates = state.candidates;
            final bookmarkedIds = state.bookmarkedIds;

            return CustomScrollView(
              slivers: [
                // 1. App Bar
                SliverAppBar.medium(
                  backgroundColor: backgroundColor,
                  surfaceTintColor: Colors.transparent,
                  title: const Text(
                    'Search Results',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => context.pop(),
                  ),
                  actions: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          "${candidates.length} Found",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // 2. List or Empty State
                if (candidates.isEmpty)
                  SliverFillRemaining(child: _buildEmptyState())
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _CandidateRichCard(
                            candidate: candidates[index],
                            primaryColor: primaryColor,
                            isBookmarked: bookmarkedIds.contains(
                              candidates[index].id,
                            ),
                            // Pass _getInitials down to the card
                            getInitials: _getInitials,
                          ),
                        );
                      }, childCount: candidates.length),
                    ),
                  ),
              ],
            );
          }

          // Fallback (e.g., CompanyInitial state)
          return _buildEmptyState();
        },
      ),
    );
  }

  // --- Helper Methods ---

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 60,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No candidates found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or location.',
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
        ],
      ),
    );
  }

  // Helper to extract initials for placeholder avatars
  String _getInitials(String name) {
    if (name.isEmpty || name == 'Unnamed Candidate') return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1 && parts[1].isNotEmpty) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name[0].toUpperCase();
  }
}

// -----------------------------------------------------------------------------
// EXTRACTED CARD WIDGET
// -----------------------------------------------------------------------------

class _CandidateRichCard extends StatelessWidget {
  final CandidateEntity candidate;
  final Color primaryColor;
  final bool isBookmarked;
  final String Function(String) getInitials; // Pass helper function

  const _CandidateRichCard({
    required this.candidate,
    required this.primaryColor,
    required this.isBookmarked,
    required this.getInitials, // Receive helper function
  });

  @override
  Widget build(BuildContext context) {
    final bool hasAvatar =
        candidate.avatarUrl != null && candidate.avatarUrl!.isNotEmpty;

    // Process skills safely
    final rawSkills = candidate.skills?.toString() ?? '';
    final skillsList = rawSkills
        .replaceAll(RegExp(r'[\[\]"]'), '')
        .split(',')
        .where((s) => s.trim().isNotEmpty)
        .map((s) => s.trim()) // Trim skills after filtering
        .take(3)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigate to candidate details
            context.pushNamed(
              'candidate-details',
              pathParameters: {'id': candidate.id},
            );
            logProfileView(candidate.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Avatar + Info + Bookmark Action
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                        image: hasAvatar
                            ? DecorationImage(
                                image: NetworkImage(candidate.avatarUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: !hasAvatar
                          ? Center(
                              child: Text(
                                getInitials(candidate.fullName),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),

                    // Main Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidate.fullName.isNotEmpty
                                ? candidate.fullName
                                : 'Unnamed Candidate',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            candidate.jobTitle ?? 'Open to work',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  candidate.city ?? 'Remote / Flexible',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bookmark Button
                    // IconButton(
                    //   onPressed: isBookmarked
                    //       ? null // Disable if already saved
                    //       : () {
                    //           context.read<CompanyBloc>().add(
                    //             AddCandidateBookmarkEvent(candidate.id),
                    //           );
                    //         },
                    //   icon: Icon(
                    //     isBookmarked
                    //         ? Icons.bookmark_rounded
                    //         : Icons.bookmark_border_rounded,
                    //   ),
                    //   color: isBookmarked ? Colors.grey[400] : primaryColor,
                    //   tooltip: isBookmarked ? 'Saved' : 'Save Candidate',
                    //   style: IconButton.styleFrom(
                    //     backgroundColor: isBookmarked
                    //         ? Colors.grey[100]
                    //         : primaryColor.withOpacity(0.1),
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                const SizedBox(height: 12),

                // Skills Chips
                if (skillsList.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skillsList.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                else
                  Text(
                    "No specific skills listed",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
