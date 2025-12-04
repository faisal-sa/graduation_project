import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import '../../domain/entities/candidate_entity.dart';

class CompanyBookmarksPage extends StatefulWidget {
  const CompanyBookmarksPage({super.key});

  @override
  State<CompanyBookmarksPage> createState() => _CompanyBookmarksPageState();
}

class _CompanyBookmarksPageState extends State<CompanyBookmarksPage> {
  final Color primaryColor = const Color(0xFF2563EB);
  final Color backgroundColor = const Color(0xFFF8F9FC);

  @override
  void initState() {
    super.initState();
    _fetchBookmarks();
  }

  void _fetchBookmarks() {
    final userId = serviceLocator.get<SupabaseClient>().auth.currentUser?.id;
    if (userId != null) {
      context.read<CompanyBloc>().add(GetCompanyBookmarksEvent(userId));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User ID not found. Cannot fetch bookmarks.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Saved Candidates',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is BookmarkRemovedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Candidate removed from bookmarks'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            _fetchBookmarks();
          }
          if (state is CompanyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompanyBookmarksLoaded) {
            final bookmarks = state.bookmarks;

            if (bookmarks.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: bookmarks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final candidate = bookmarks[index];

                return Dismissible(
                  key: Key(candidate.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  onDismissed: (direction) {
                    context.read<CompanyBloc>().add(
                      RemoveCandidateBookmarkEvent(candidate.id),
                    );
                  },
                  child: _buildBookmarkCard(context, candidate),
                );
              },
            );
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildBookmarkCard(BuildContext context, CandidateEntity c) {
    final rawSkills = c.skills?.toString() ?? '';
    final skillsList = rawSkills
        .replaceAll(RegExp(r'[\[\]"]'), '')
        .split(',')
        .where((s) => s.trim().isNotEmpty)
        .take(2)
        .toList();

    final bool hasAvatar = c.avatarUrl != null && c.avatarUrl!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showRemoveDialog(context, c),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  image: hasAvatar
                      ? DecorationImage(
                          image: NetworkImage(c.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: !hasAvatar
                    ? Center(
                        child: Text(
                          _getInitials(c.fullName),
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

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      c.jobTitle ?? c.city ?? 'Available',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    if (skillsList.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        children: skillsList
                            .map(
                              (skill) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Text(
                                  skill.trim(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.bookmark_border, size: 50, color: primaryColor),
          ),
          const SizedBox(height: 20),
          const Text(
            'No saved candidates yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Saved candidates will appear here.',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: _fetchBookmarks,
            icon: Icon(Icons.refresh, color: primaryColor),
            label: Text("Refresh List", style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name[0].toUpperCase();
  }

  void _showRemoveDialog(BuildContext context, CandidateEntity c) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 250,
          child: Column(
            children: [
              const Text(
                "Manage Candidate",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Do you want to remove ${c.fullName} from your saved list?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<CompanyBloc>().add(
                      RemoveCandidateBookmarkEvent(c.id),
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  label: const Text(
                    "Remove from Bookmarks",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        );
      },
    );
  }
}
