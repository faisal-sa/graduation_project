import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/exports/app_exports.dart';
import '../../domain/entities/candidate_entity.dart';

class CompanySearchPage extends StatelessWidget {
  const CompanySearchPage({super.key});

  // Dispatch initial search on first load
  void _performInitialSearch(BuildContext context) {
    context.read<CompanyBloc>().add(const SearchCandidatesEvent(city: null));
  }

  // Add bookmark
  void _addBookmark(BuildContext context, String candidateId) {
    context.read<CompanyBloc>().add(AddCandidateBookmarkEvent(candidateId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Search (Home)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.goNamed('company-advanced-search'),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.goNamed('company-bookmarks'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goNamed('company-settings'),
          ),
        ],
      ),

      body: BlocListener<CompanyBloc, CompanyState>(
        listenWhen: (previous, current) => current is CompanyInitial,
        listener: (context, state) {
          if (state is CompanyInitial) {
            _performInitialSearch(context);
          }

          if (state is BookmarkAddedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Candidate bookmarked!')),
            );
          }

          if (state is CompanyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },

        child: BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, state) {
            if (state is CompanyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CandidateResults) {
              return _buildCandidateList(context, state.candidates);
            }

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome! Start searching for talent.'),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCandidateList(
    BuildContext context,
    List<CandidateEntity> candidates,
  ) {
    if (candidates.isEmpty) {
      return const Center(
        child: Text('No candidates found matching your criteria.'),
      );
    }

    return ListView.builder(
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        final candidate = candidates[index];

        return ListTile(
          title: Text(candidate.fullName),
          subtitle: Text(
            '${candidate.skills ?? 'No skills'} - ${candidate.city ?? 'N/A'}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.star_border),
            color: Colors.amber,
            onPressed: () => _addBookmark(context, candidate.id),
          ),
          onTap: () {
            // Go to candidate profile later…
          },
        );
      },
    );
  }
}
