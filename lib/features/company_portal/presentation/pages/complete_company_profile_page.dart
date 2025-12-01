// lib/features/company_portal/presentation/pages/complete_company_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/exports/app_exports.dart';
import '../../domain/entities/company_entity.dart';

class CompleteCompanyProfilePage extends StatelessWidget {
  CompleteCompanyProfilePage({super.key});

  final _companyNameController = TextEditingController();
  final _industryController = TextEditingController();
  final _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _saveProfile(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // (Logic to fetch companyId and userId remains the same)
      const companyId = 'PLACEHOLDER_COMPANY_ID_IF_EXISTS';
      const userId = 'PLACEHOLDER_USER_ID';

      final newCompanyEntity = CompanyEntity(
        id: companyId,
        userId: userId,
        companyName: _companyNameController.text,
        industry: _industryController.text,
        city: _cityController.text,
        description: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      context.read<CompanyBloc>().add(
        UpdateCompanyProfileEvent(newCompanyEntity),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CompanyLoading) {
            // Show loading
          } else if (state is CompanyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to save profile: ${state.message}'),
              ),
            );
          } else if (state is CompanyLoaded) {
            // 🛑 FIX: Route directly to Search Home after success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile saved! Routing to Search.'),
              ),
            );
            context.goNamed('company-search');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(labelText: 'Company Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Name is required' : null,
                ),
                TextFormField(
                  controller: _industryController,
                  decoration: const InputDecoration(labelText: 'Industry'),
                  validator: (value) =>
                      value!.isEmpty ? 'Industry is required' : null,
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) =>
                      value!.isEmpty ? 'City is required' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => _saveProfile(context),
                  child: const Text('Save and Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
