import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class AdvancedSearchPage extends StatelessWidget {
  const AdvancedSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final city = TextEditingController();
    final skill = TextEditingController();
    final experience = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('بحث متقدم')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: city,
              decoration: const InputDecoration(labelText: 'المدينة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: skill,
              decoration: const InputDecoration(labelText: 'المهارة'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: experience,
              decoration: const InputDecoration(
                labelText: 'عدد سنوات الخبرة (مثلاً 3 سنوات)',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('بحث'),
              onPressed: () {
                context.read<CompanyBloc>().add(
                  SearchCandidatesEvent(
                    city: city.text.isEmpty ? null : city.text,
                    skill: skill.text.isEmpty ? null : skill.text,
                    experience: experience.text.isEmpty
                        ? null
                        : experience.text,
                  ),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
