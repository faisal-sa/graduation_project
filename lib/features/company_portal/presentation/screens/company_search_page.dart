import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import '../../domain/entities/candidate_entity.dart';

class CompanySearchPage extends StatelessWidget {
  CompanySearchPage({super.key});
  // Controllers for the input fields
  final _cityController = TextEditingController();
  final _skillController = TextEditingController();
  final _experienceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to dispatch the search event
  void _performSearch(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final city = _cityController.text.trim();
      final skill = _skillController.text.trim();
      final experience = _experienceController.text.trim();

      // Dispatch the event using the current filter values
      context.read<CompanyBloc>().add(
        SearchCandidatesEvent(
          city: city.isNotEmpty ? city : null,
          skill: skill.isNotEmpty ? skill : null,
          experience: experience.isNotEmpty ? experience : null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('  Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.goNamed('company-bookmarks'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goNamed('company-settings'),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('company-search'),
        ),
      ),
      body: BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is BookmarkAddedSuccessfully) {
            print("bookmark added");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bookmark added successfully')),
            );
          }
        },
        child: Column(
          children: [
            Image.asset("assets/icons/flutter.png", width: 300, height: 300),

            _buildFilterForm(context),
            const Divider(),
            // Use BlocBuilder to display results
            Expanded(
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  print(state);
                  if (state is CompanyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CandidateResults) {
                    return _buildCandidateList(context, state.candidates);
                  }
                  if (state is CompanyError) {
                    return Center(
                      child: Text(
                        'Search failed: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  // Default state when results haven't been fetched or cleared
                  return const Center(
                    child: Text(
                      'Enter criteria above and click Search.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildFilterForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _skillController,
              decoration: const InputDecoration(
                labelText: 'Skills (e.g., Flutter, Python)',
                prefixIcon: Icon(Icons.code),
              ),
            ),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City/Location (e.g., Riyadh)',
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            TextFormField(
              controller: _experienceController,
              decoration: const InputDecoration(
                labelText: 'Experience Level (e.g., Senior, Mid-level)',
                prefixIcon: Icon(Icons.work),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _performSearch(context),
              icon: const Icon(Icons.search),
              label: const Text('SEARCH CANDIDATES'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
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
        child: Text('No candidates found matching your filters.'),
      );
    }

    // Assuming the company is already loaded and we need the company ID for bookmarking
    const companyId = 'CURRENT_COMPANY_ID';

    return ListView.builder(
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        final candidate = candidates[index];
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            candidate.fullName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${candidate.skills ?? 'N/A'} - ${candidate.city ?? 'Anywhere'}',
          ),
          // trailing: IconButton(
          //   icon: candidate.bookmarked
          //       ? const Icon(Icons.bookmark)
          //       : const Icon(Icons.bookmark_add_outlined),
          //   color: Colors.blue,
          //   onPressed: () {
          //     // Dispatch bookmark event
          //     context.read<CompanyBloc>().add(
          //       AddCandidateBookmarkEvent(candidate.id),
          //     );

          //   },
          // ),
          onTap: () {
            // Navigate to detailed candidate view
          },
        );
      },
    );

    // Example: Dispatches the bookmark event
    // void _addBookmark(BuildContext context, String candidateId) {
    //   context.read<CompanyBloc>().add(AddCandidateBookmarkEvent(candidateId));
    // }

    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Candidate Search (Home)'),
    //       actions: [
    //         IconButton(
    //           icon: const Icon(Icons.search),
    //           onPressed: () => context.goNamed('company-advanced-search'),
    //         ),
    //         IconButton(
    //           icon: const Icon(Icons.bookmark),
    //           onPressed: () => context.goNamed('company-bookmarks'),
    //         ),
    //         IconButton(
    //           icon: const Icon(Icons.settings),
    //           onPressed: () => context.goNamed('company-settings'),
    //         ),
    //       ],
    //     ),
    //     body: BlocListener<CompanyBloc, CompanyState>(
    //       listener: (context, state) {
    //         if (state is BookmarkAddedSuccessfully) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             const SnackBar(content: Text('Candidate bookmarked!')),
    //           );
    //         }
    //         if (state is CompanyError) {
    //           ScaffoldMessenger.of(
    //             context,
    //           ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
    //         }
    //       },
    //       child: BlocBuilder<CompanyBloc, CompanyState>(
    //         builder: (context, state) {
    //           if (state is CompanyLoading) {
    //             return const Center(child: CircularProgressIndicator());
    //           }
    //           if (state is CandidateResults) {
    //             return _buildCandidateList(
    //               context,
    //               state.candidates.cast<CandidateEntity>(),
    //             );
    //           }

    //           // Default welcome view
    //           return const Center(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text('Welcome! Start searching for talent.'),
    //                 SizedBox(height: 20),
    //                 // Add a quick search bar here
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   );
    // }
  }
}
