import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/blocs/bloc/bookmarks_bloc.dart';
import 'package:graduation_project/features/company_search/presentation/blocs/bloc/search_bloc.dart';
import 'package:graduation_project/features/company_search/presentation/screens/widgets/candidate_rich_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class CandidateResultsPage extends StatelessWidget {
  const CandidateResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const backgroundColor = Color(0xFFF2F4F8);
    final companyId = Supabase.instance.client.auth.currentUser?.id ?? '';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<BookmarksBloc, BookmarksState>(
            listener: (context, state) {
              if (state is BookmarksError) {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flatColored,
                  title: const Text('Action Failed'),
                  description: Text(state.message),
                  autoCloseDuration: const Duration(seconds: 3),
                );
              }
            },
          ),
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchError) {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flatColored,
                  title: const Text('Search Error'),
                  description: Text(state.message),
                  autoCloseDuration: const Duration(seconds: 4),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(height: 16),
                    Text(
                      "Finding best matches...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            if (state is SearchResultsLoaded) {
              final candidates = state.candidates;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar.medium(
                    backgroundColor: backgroundColor,
                    scrolledUnderElevation: 0,
                    leading: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    title: const Text(
                      'Search Results',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    actions: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${candidates.length} Found",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (candidates.isEmpty)
                    SliverFillRemaining(child: _buildEmptyState())
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final candidate = candidates[index];

                          return TweenAnimationBuilder<double>(
                            duration: Duration(
                              milliseconds: 300 + (index * 50),
                            ),
                            tween: Tween(begin: 0.0, end: 1.0),
                            curve: Curves.easeOutQuad,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: Opacity(
                                  opacity: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ),
                                    child: _buildModernCardWrapper(
                                      child: // داخل ListView.builder
                                      CandidateRichCard(
                                        candidate: candidate,
                                        primaryColor: primaryColor,

                                        initialIsBookmarked:
                                            candidate.bookmarked,

                                        onTap: () async {
                                          final bool? result = await context
                                              .pushNamed<bool>(
                                                'candidate-details',
                                                pathParameters: {
                                                  'id': candidate.id,
                                                },
                                              );

                                          if (result != null &&
                                              result != candidate.bookmarked) {
                                            if (context.mounted) {
                                              context.read<SearchBloc>().add(
                                                UpdateLocalBookmarkEvent(
                                                  candidateId: candidate.id,
                                                  isBookmarked: result,
                                                ),
                                              );
                                            }
                                          }
                                        },

                                        onBookmarkToggle:
                                            (bool isNowBookmarked) {
                                              if (isNowBookmarked) {
                                                context
                                                    .read<BookmarksBloc>()
                                                    .add(
                                                      AddBookmarkEvent(
                                                        candidateId:
                                                            candidate.id,
                                                        companyId: companyId,
                                                      ),
                                                    );
                                              } else {
                                                context
                                                    .read<BookmarksBloc>()
                                                    .add(
                                                      RemoveBookmarkEvent(
                                                        candidateId:
                                                            candidate.id,
                                                        companyId: companyId,
                                                      ),
                                                    );
                                              }

                                              context.read<SearchBloc>().add(
                                                UpdateLocalBookmarkEvent(
                                                  candidateId: candidate.id,
                                                  isBookmarked: isNowBookmarked,
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }, childCount: candidates.length),
                      ),
                    ),
                ],
              );
            }
            return _buildEmptyState();
          },
        ),
      ),
    );
  }

  Widget _buildModernCardWrapper({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(24), child: child),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 50, color: Colors.grey[400]),
          const SizedBox(height: 24),
          Text(
            'No Candidates Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
