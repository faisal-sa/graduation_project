import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/shared/data/domain/entities/company_entity.dart';
import 'package:graduation_project/core/storage/company_local_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteCompanyProfilePage extends StatefulWidget {
  const CompleteCompanyProfilePage({super.key});

  @override
  State<CompleteCompanyProfilePage> createState() =>
      _CompleteCompanyProfilePageState();
}

class _CompleteCompanyProfilePageState
    extends State<CompleteCompanyProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController nameController;
  late TextEditingController industryController;
  late TextEditingController cityController;
  late TextEditingController descController;
  late TextEditingController websiteController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  String? selectedSize;

  bool _isSaving = false;

  final sizeOptions = [
    '1-50 employees',
    '51-200 employees',
    '201-1000 employees',
    '1000+ employees',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    industryController = TextEditingController();
    cityController = TextEditingController();
    descController = TextEditingController();
    websiteController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    _fetchInitialData();
  }

  void _fetchInitialData() {
    final userId = serviceLocator.get<SupabaseClient>().auth.currentUser?.id;
    if (userId != null) {
      context.read<CompanyBloc>().add(GetCompanyProfileEvent(userId));
    }
  }

  void _populateControllers(CompanyEntity company) {
    nameController.text = company.companyName;
    industryController.text = company.industry;
    cityController.text = company.city;
    descController.text = company.description;
    websiteController.text = company.website ?? '';
    addressController.text = company.address ?? '';
    emailController.text = company.email ?? '';
    phoneController.text = company.phone ?? '';

    if (sizeOptions.contains(company.companySize)) {
      setState(() {
        selectedSize = company.companySize;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    industryController.dispose();
    cityController.dispose();
    descController.dispose();
    websiteController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _saveProfile(CompanyEntity currentCompany) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSaving = true;
      });

      final updated = currentCompany.copyWith(
        companyName: nameController.text.trim(),
        industry: industryController.text.trim(),
        city: cityController.text.trim(),
        description: descController.text.trim(),
        website: websiteController.text.trim(),
        address: addressController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        companySize: selectedSize ?? currentCompany.companySize,
        updatedAt: DateTime.now(),
      );

      context.read<CompanyBloc>().add(
        UpdateCompanyProfileEvent(company: updated),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const backgroundColor = Color(0xFFF8F9FD);

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: _buildBottomBar(context, primaryColor),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) async {
          if (state is CompanyLoaded) {
            if (!_isSaving) {
              _populateControllers(state.company);
            } else {
              setState(() {
                _isSaving = false;
              });

              final userId = serviceLocator
                  .get<SupabaseClient>()
                  .auth
                  .currentUser
                  ?.id;
              if (userId != null) {
                await CompanyLocalStorage.saveCompanyId(userId);
              }

              if (mounted) {
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.flatColored,
                  title: const Text('Profile Saved'),
                  description: const Text(
                    'Your company details have been updated.',
                  ),
                  alignment: Alignment.topRight,
                  autoCloseDuration: const Duration(seconds: 4),
                  borderRadius: BorderRadius.circular(12.0),
                );
                context.go('/company/search');
              }
            }
          } else if (state is CompanyError) {
            setState(() {
              _isSaving = false;
            });

            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              title: const Text('Update Failed'),
              description: Text(state.message),
              alignment: Alignment.topRight,
              autoCloseDuration: const Duration(seconds: 5),
            );
          }
        },
        builder: (context, state) {
          if (state is CompanyLoading && !_isSaving) {
            return const Center(child: CircularProgressIndicator());
          }

          final company = (state is CompanyLoaded)
              ? state.company
              : CompanyEntity(
                  companyName: '',
                  industry: '',
                  description: '',
                  city: '',
                  logoUrl: "",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

          return CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                backgroundColor: backgroundColor,
                surfaceTintColor: Colors.transparent,
                title: const Text(
                  'Profile Setup',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => context.pop(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildSectionTitle('Essentials'),
                        const SizedBox(height: 10),

                        _ModernTextField(
                          controller: nameController,
                          label: 'Company Name',
                          hint: 'e.g. Acme Corp',
                          icon: Icons.business,
                          validator: (v) =>
                              v!.isEmpty ? 'Name is required' : null,
                        ),
                        const SizedBox(height: 12),
                        _ModernTextField(
                          controller: industryController,
                          label: 'Industry',
                          hint: 'e.g. SaaS, Retail',
                          icon: Icons.category_outlined,
                          validator: (v) =>
                              v!.isEmpty ? 'Industry is required' : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: _ModernTextField(
                                controller: cityController,
                                label: 'City',
                                icon: Icons.location_on_outlined,
                                validator: (v) =>
                                    v!.isEmpty ? 'Required' : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 4,
                              child: _ModernDropdown(
                                value: selectedSize,
                                label: 'Size',
                                items: sizeOptions,
                                onChanged: (v) =>
                                    setState(() => selectedSize = v),
                                onSaved: (v) => selectedSize = v,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _ModernTextField(
                          controller: descController,
                          label: 'About the company',
                          hint: 'Short description...',
                          icon: Icons.short_text_rounded,
                          maxLines: 4,
                          validator: (v) =>
                              v!.isEmpty ? 'Description is required' : null,
                        ),
                        const SizedBox(height: 30),
                        _buildSectionTitle('Contact Details'),
                        const SizedBox(height: 10),
                        _ModernTextField(
                          controller: websiteController,
                          label: 'Website',
                          hint: 'https://...',
                          icon: Icons.link,
                          isUrl: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernTextField(
                          controller: emailController,
                          label: 'Public Email',
                          icon: Icons.email_outlined,
                          isEmail: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernTextField(
                          controller: phoneController,
                          label: 'Phone',
                          icon: Icons.phone_outlined,
                          isPhone: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernTextField(
                          controller: addressController,
                          label: 'Address',
                          icon: Icons.map_outlined,
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, state) {
            final isSavingNow = state is CompanyLoading && _isSaving;

            return ElevatedButton(
              onPressed: isSavingNow
                  ? null
                  : () {
                      final company = (state is CompanyLoaded)
                          ? state.company
                          : CompanyEntity(
                              companyName: '',
                              industry: '',
                              description: '',
                              city: '',
                              logoUrl: "",
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                      _saveProfile(company);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: isSavingNow
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _ModernTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool isEmail;
  final bool isPhone;
  final bool isUrl;
  final int maxLines;

  const _ModernTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.validator,
    this.isEmail = false,
    this.isPhone = false,
    this.isUrl = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone
            ? TextInputType.phone
            : isUrl
            ? TextInputType.url
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey[400], size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintStyle: TextStyle(color: Colors.grey[300]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class _ModernDropdown extends StatelessWidget {
  final String? value;
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldSetter<String>? onSaved;

  const _ModernDropdown({
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Segoe UI',
        ),
        items: items
            .map(
              (s) => DropdownMenuItem(
                value: s,
                child: Text(s, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: onChanged,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            Icons.groups_rounded,
            color: Colors.grey[400],
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
