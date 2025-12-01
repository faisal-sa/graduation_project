import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/exports/app_exports.dart';
import '../../domain/entities/candidate_entity.dart';

class AdvancedSearchPage extends StatelessWidget {
  AdvancedSearchPage({super.key});

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
        title: const Text('Advanced Candidate Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('company-search'),
        ),
      ),
      body: Column(
        children: [
          _buildFilterForm(context),
          const Divider(),
          // Use BlocBuilder to display results
          Expanded(
            child: BlocBuilder<CompanyBloc, CompanyState>(
              buildWhen: (previous, current) =>
                  current is CompanyLoading ||
                  current is CandidateResults ||
                  current is CompanyError,
              builder: (context, state) {
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
          trailing: IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            color: Colors.blue,
            onPressed: () {
              // Dispatch bookmark event
              context.read<CompanyBloc>().add(
                AddCandidateBookmarkEvent(candidate.id),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Attempting to bookmark ${candidate.fullName}...',
                  ),
                ),
              );
            },
          ),
          onTap: () {
            // Navigate to detailed candidate view
          },
        );
      },
    );
  }
}
