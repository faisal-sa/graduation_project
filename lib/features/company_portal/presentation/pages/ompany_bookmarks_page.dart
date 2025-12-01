import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/exports/app_exports.dart';

class CompanyBookmarksPage extends StatelessWidget {
  const CompanyBookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the load event when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 💡 You need the company ID, which should be available via a BLoC or argument
      const companyId = 'CURRENT_COMPANY_ID';
      context.read<CompanyBloc>().add(
        const GetCompanyBookmarksEvent(companyId),
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Candidates')),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CompanyBookmarksLoaded) {
            if (state.bookmarks.isEmpty) {
              return const Center(child: Text('No candidates bookmarked yet.'));
            }
            return ListView.builder(
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final candidate = state.bookmarks[index];
                return ListTile(
                  title: Text(candidate.fullName),
                  subtitle: Text(candidate.skills ?? 'No skills listed'),
                  // Add logic here to remove bookmark if needed
                );
              },
            );
          }
          if (state is CompanyError) {
            return Center(
              child: Text('Error loading bookmarks: ${state.message}'),
            );
          }

          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }
}
