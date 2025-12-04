import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class CompanySearchPage extends StatefulWidget {
  const CompanySearchPage({super.key});

  @override
  State<CompanySearchPage> createState() => _CompanySearchPageState();
}

class _CompanySearchPageState extends State<CompanySearchPage> {
  final _cityController = TextEditingController();
  final _skillController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> selectedTypes = [];
  bool canRelocateValue = false;
  List<String> selectedLanguages = [];
  List<String> selectedModes = [];
  String? selectedJobTitle;
  List<String> targetRolesList = [];

  // Data
  final List<String> availableLanguages = [
    'Arabic',
    'English',
    'French',
    'Spanish',
  ];
  final List<String> availableWorkModes = ['Remote', 'Hybrid', 'On-Site'];
  final List<String> availableTargetRoles = [
    'Team Lead',
    'Senior',
    'Junior',
    'Intern',
  ];

  final Color primaryColor = const Color(0xFF2563EB);
  final Color backgroundColor = const Color(0xFFF8F9FC);
  final Color surfaceColor = Colors.white;
  final Color textColor = const Color(0xFF1E293B);

  void _performSearch(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final city = _cityController.text.trim();
      final skill = _skillController.text.trim();

      context.read<CompanyBloc>().add(
        SearchCandidatesEvent(
          location: city.isNotEmpty ? city : null,
          skills: skill.isNotEmpty ? [skill] : null,
          employmentTypes: selectedTypes.isNotEmpty ? selectedTypes : null,
          canRelocate: canRelocateValue ? true : null,
          languages: selectedLanguages.isNotEmpty ? selectedLanguages : null,
          workModes: selectedModes.isNotEmpty ? selectedModes : null,
          jobTitle: (selectedJobTitle != null && selectedJobTitle!.isNotEmpty)
              ? selectedJobTitle
              : null,
          targetRoles: targetRolesList.isNotEmpty ? targetRolesList : null,
        ),
      );

      context.pushNamed(
        'company-search-results',
        extra: context.read<CompanyBloc>(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Find Talent',
          style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_rounded, color: textColor),
            onPressed: () => context.goNamed('company-bookmarks'),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: textColor),
            onPressed: () => context.goNamed('company-settings'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => _performSearch(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Search Candidates',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Logo or Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.search, size: 30, color: primaryColor),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hire the best.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "Filter to find your perfect match.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              _buildSectionTitle("KEY CRITERIA"),
              _buildModernInputField(
                controller: _skillController,
                label: 'Skills or Keywords',
                hint: 'e.g. Flutter, React, Python',
                icon: Icons.code_rounded,
              ),
              const SizedBox(height: 16),
              _buildModernInputField(
                controller: _cityController,
                label: 'Location',
                hint: 'e.g. Riyadh, Dubai',
                icon: Icons.location_on_outlined,
              ),

              const SizedBox(height: 16),

              // Job Title Dropdown
              _buildDropdownField(),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: primaryColor,
                  title: Text(
                    "Willing to relocate?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    "Show candidates ready to move",
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  value: canRelocateValue,
                  onChanged: (v) => setState(() => canRelocateValue = v),
                ),
              ),

              const SizedBox(height: 30),

              _buildSectionTitle("PREFERENCES"),

              _buildFilterGroup(
                title: "Work Mode",
                icon: Icons.work_outline,
                options: availableWorkModes,
                selectedList: selectedModes,
              ),
              const Divider(height: 30, color: Color(0xFFEEEEEE)),

              _buildFilterGroup(
                title: "Target Roles",
                icon: Icons.person_outline,
                options: availableTargetRoles,
                selectedList: targetRolesList,
              ),
              const Divider(height: 30, color: Color(0xFFEEEEEE)),

              _buildFilterGroup(
                title: "Languages",
                icon: Icons.language,
                options: availableLanguages,
                selectedList: selectedLanguages,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildModernInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(icon, color: primaryColor.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 1.5),
          ),
          filled: true,
          fillColor: surfaceColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        initialValue: selectedJobTitle,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        items: const [
          DropdownMenuItem(
            value: 'Mobile Developer',
            child: Text('Mobile Developer'),
          ),
          DropdownMenuItem(
            value: 'Backend Developer',
            child: Text('Backend Developer'),
          ),
          DropdownMenuItem(
            value: 'Frontend Developer',
            child: Text('Frontend Developer'),
          ),
          DropdownMenuItem(
            value: 'UI/UX Designer',
            child: Text('UI/UX Designer'),
          ),
        ],
        onChanged: (v) => setState(() => selectedJobTitle = v),
        decoration: InputDecoration(
          labelText: 'Specific Job Title',
          prefixIcon: Icon(
            Icons.badge_outlined,
            color: primaryColor.withOpacity(0.7),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterGroup({
    required String title,
    required IconData icon,
    required List<String> options,
    required List<String> selectedList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: options.map((option) {
            final isSelected = selectedList.contains(option);
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedList.remove(option);
                  } else {
                    selectedList.add(option);
                  }
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
