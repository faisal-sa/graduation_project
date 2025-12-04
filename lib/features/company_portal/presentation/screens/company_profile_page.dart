import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Profile')),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CompanyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CompanyLoaded) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile updated')));
          }
        },
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyLoaded) {
            final c = state.company;
            final name = TextEditingController(text: c.companyName);
            final industry = TextEditingController(text: c.industry);
            final desc = TextEditingController(text: c.description);
            final city = TextEditingController(text: c.city);
            final website = TextEditingController(text: c.website);
            final phone = TextEditingController(text: c.phone);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                    ),
                  ),
                  TextField(
                    controller: industry,
                    decoration: const InputDecoration(labelText: 'Industry'),
                  ),
                  TextField(
                    controller: desc,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: city,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                  TextField(
                    controller: website,
                    decoration: const InputDecoration(labelText: 'Website'),
                  ),
                  TextField(
                    controller: phone,
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final updated = c.copyWith(
                        companyName: name.text,
                        industry: industry.text,
                        description: desc.text,
                        city: city.text,
                        website: website.text,
                        phone: phone.text,
                      );
                      context.read<CompanyBloc>().add(
                        UpdateCompanyProfileEvent(updated),
                      );
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
