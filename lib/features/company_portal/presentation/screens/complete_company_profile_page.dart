// complete_company_profile_page.dart
// Main page UI logic with validation and navigation to payment page

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/domain/entities/company_entity.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/components/customInput.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/components/header_stepIndicator.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/components/validation_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteCompanyProfilePage extends StatelessWidget {
  const CompleteCompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    final _formKey = GlobalKey<FormState>();

    final name = TextEditingController();
    final industry = TextEditingController();
    final description = TextEditingController();
    final city = TextEditingController();
    final address = TextEditingController();
    final companySize = TextEditingController();
    final website = TextEditingController();
    final email = TextEditingController(text: user?.email ?? '');
    final phone = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('📝 إكمال ملف الشركة'), elevation: 0),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CompanyLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ تم حفظ الملف بنجاح')),
            );
            context.push('/company/payment');
          } else if (state is CompanyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const HeaderStepIndicator(step: 1, totalSteps: 3),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomInput(
                          controller: name,
                          label: 'اسم الشركة',
                          icon: Icons.apartment,
                          validator: (value) => ValidationHelper.requiredField(
                            value,
                            fieldName: 'اسم الشركة',
                          ),
                        ),
                        CustomInput(
                          controller: industry,
                          label: 'القطاع الصناعي',
                          icon: Icons.factory,
                          validator: (value) => ValidationHelper.requiredField(
                            value,
                            fieldName: 'القطاع الصناعي',
                          ),
                        ),
                        CustomInput(
                          controller: description,
                          label: 'الوصف',
                          icon: Icons.description,
                          validator: (value) => ValidationHelper.requiredField(
                            value,
                            fieldName: 'الوصف',
                          ),
                        ),
                        CustomInput(
                          controller: city,
                          label: 'المدينة',
                          icon: Icons.location_city,
                          validator: (value) => ValidationHelper.requiredField(
                            value,
                            fieldName: 'المدينة',
                          ),
                        ),
                        CustomInput(
                          controller: address,
                          label: 'العنوان',
                          icon: Icons.map,
                          validator: (value) => ValidationHelper.requiredField(
                            value,
                            fieldName: 'العنوان',
                          ),
                        ),
                        CustomInput(
                          controller: companySize,
                          label: 'حجم الشركة',
                          icon: Icons.groups,
                          validator: (value) => ValidationHelper.requiredField(
                            value,
                            fieldName: 'حجم الشركة',
                          ),
                        ),
                        CustomInput(
                          controller: website,
                          label: 'الموقع الإلكتروني',
                          icon: Icons.link,
                          validator: ValidationHelper.url,
                        ),
                        CustomInput(
                          controller: email,
                          label: 'البريد الإلكتروني',
                          icon: Icons.email,
                          validator: ValidationHelper.email,
                        ),
                        CustomInput(
                          controller: phone,
                          label: 'رقم الهاتف',
                          icon: Icons.phone,
                          validator: ValidationHelper.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        final entity = CompanyEntity(
                          id: '',
                          userId: user!.id,
                          companyName: name.text,
                          industry: industry.text,
                          description: description.text,
                          city: city.text,
                          address: address.text,
                          companySize: companySize.text,
                          website: website.text,
                          email: email.text,
                          phone: phone.text,
                          logoUrl: '',
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );

                        context.read<CompanyBloc>().add(
                          UpdateCompanyProfileEvent(entity),
                        );
                      },
                      child: const Text(
                        'حفظ ومتابعة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
