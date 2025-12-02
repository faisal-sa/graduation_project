import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/company_portal/domain/entities/company_entity.dart';
import 'package:graduation_project/core/storage/company_local_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteCompanyProfilePage extends StatelessWidget {
  const CompleteCompanyProfilePage({super.key});

  Widget _buildVerticalSpace({double height = 16.0}) =>
      SizedBox(height: height);

  Widget _buildHeader(String title, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        title + (isRequired ? ' *' : ''),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: "a");
    final industryController = TextEditingController(text: "a");
    final cityController = TextEditingController(text: "a");
    final descController = TextEditingController(text: "a");
    final websiteController = TextEditingController();
    final addressController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    final sizeOptions = [
      '1-50 employees',
      '51-200 employees',
      '201-1000 employees',
      '1000+ employees',
    ];
    String? selectedSize;

    // The logic remains untouched
    void saveProfile(CompanyEntity company) {
      if (formKey.currentState!.validate()) {
        // Ensure DropdownButtonFormField updates the selectedSize value
        formKey.currentState!.save();

        final updated = company.copyWith(
          companyName: nameController.text,
          industry: industryController.text,
          city: cityController.text,
          description: descController.text,
          website: websiteController.text.isNotEmpty
              ? websiteController.text
              : company.website,
          address: addressController.text.isNotEmpty
              ? addressController.text
              : company.address,
          email: emailController.text.isNotEmpty
              ? emailController.text
              : company.email,
          phone: phoneController.text.isNotEmpty
              ? phoneController.text
              : company.phone,
          companySize: selectedSize ?? company.companySize,
          updatedAt: DateTime.now(),
        );

        context.read<CompanyBloc>().add(UpdateCompanyProfileEvent(updated));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Company Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) async {
          if (state is CompanyLoaded) {
            await CompanyLocalStorage.saveCompanyId(
              serviceLocator.get<SupabaseClient>().auth.currentUser!.id,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile saved successfully!')),
            );
            context.go('/company/payment');
          } else if (state is CompanyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Error: ${state.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Default company entity if not yet loaded
          CompanyEntity company;
          if (state is CompanyLoaded) {
            company = state.company;
          } else {
            company = CompanyEntity(
              companyName: '',
              industry: '',
              description: '',
              city: '',
              logoUrl: "x",
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
          }

          // // Fill fields with existing values (unchanged logic)
          // nameController.text = company.companyName;
          // industryController.text = company.industry;
          // cityController.text = company.city;
          // descController.text = company.description;
          // websiteController.text = company.website ?? '';
          // addressController.text = company.address ?? '';
          // emailController.text = company.email ?? '';
          // phoneController.text = company.phone ?? '';
          selectedSize = company.companySize;

          // UI Refactoring begins here
          return SafeArea(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  // --- Section 1: Core Company Information ---
                  const Text(
                    'Step 1: Core Company Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  _buildVerticalSpace(height: 20),

                  _buildHeader('Company Name', isRequired: true),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., Acme Corporation',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? 'Company name is required' : null,
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('Industry', isRequired: true),
                  TextFormField(
                    controller: industryController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., Software Development, Finance',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? 'Industry is required' : null,
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('City', isRequired: true),
                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., New York, London',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v!.isEmpty ? 'City is required' : null,
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('Company Size'),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Company Size',
                    ),
                    value: selectedSize,
                    items: sizeOptions
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      selectedSize = v;
                    },
                    onSaved: (v) =>
                        selectedSize = v, // Save to update selectedSize
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('Description', isRequired: true),
                  TextFormField(
                    controller: descController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Tell us about your company...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    validator: (v) =>
                        v!.isEmpty ? 'Description is required' : null,
                  ),
                  _buildVerticalSpace(height: 30),

                  // --- Section 2: Contact Information ---
                  const Text(
                    'Step 2: Contact Details (Optional)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  _buildVerticalSpace(height: 20),

                  _buildHeader('Website'),
                  TextFormField(
                    controller: websiteController,
                    decoration: const InputDecoration(
                      hintText: 'https://example.com',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('Address'),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: 'Company physical address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('Email'),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'contact@example.com',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildVerticalSpace(),

                  _buildHeader('Phone'),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: '+1 555 123 4567',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  _buildVerticalSpace(height: 40),

                  // --- Save Button ---
                  Center(
                    child: ElevatedButton(
                      onPressed: () => saveProfile(company),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: state is CompanyLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Save and Continue',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                  _buildVerticalSpace(height: 20), // Final space at the bottom
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
