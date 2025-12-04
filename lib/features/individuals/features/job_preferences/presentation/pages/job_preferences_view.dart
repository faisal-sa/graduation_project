import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation_project/app/widgets/custom_text_field.dart';
import 'package:graduation_project/app/widgets/saving_button.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/dynamic_list_section.dart';
import '../../domain/entities/job_preferences_entity.dart';
import '../cubit/job_preferences_cubit.dart';

class JobPreferencesView extends StatefulWidget {
  const JobPreferencesView({super.key});

  @override
  State<JobPreferencesView> createState() => _JobPreferencesViewState();
}

class _JobPreferencesViewState extends State<JobPreferencesView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();
  final TextEditingController _noticePeriodController = TextEditingController();

  // Local State
  List<String> _targetRoles = [];
  List<String> _employmentTypes = [];
  List<String> _workModes = [];

  final String _salaryCurrency = 'SAR';
  bool _canRelocate = false;
  bool _canStartImmediately = false;

  final List<String> _availableWorkModes = ['Remote', 'On-site', 'Hybrid'];
  final List<String> _availableEmpTypes = [
    'Full-time',
    'Part-time',
    'Contract',
    'Freelance',
    'Co-op',
  ];

  @override
  void dispose() {
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    _noticePeriodController.dispose();
    super.dispose();
  }

  void _initializeValues(JobPreferencesEntity prefs) {
    _targetRoles = List.from(prefs.targetRoles);
    _employmentTypes = List.from(prefs.employmentTypes);
    _workModes = List.from(prefs.workModes);
    _minSalaryController.text = prefs.minSalary?.toString() ?? '';
    _maxSalaryController.text = prefs.maxSalary?.toString() ?? '';
    _canRelocate = prefs.canRelocate;
    _canStartImmediately = prefs.canStartImmediately;
    _noticePeriodController.text = prefs.noticePeriodDays?.toString() ?? '';
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final entity = JobPreferencesEntity(
        targetRoles: _targetRoles,
        minSalary: int.tryParse(_minSalaryController.text),
        maxSalary: int.tryParse(_maxSalaryController.text),
        salaryCurrency: _salaryCurrency,
        employmentTypes: _employmentTypes,
        workModes: _workModes,
        canRelocate: _canRelocate,
        canStartImmediately: _canStartImmediately,
        noticePeriodDays: _canStartImmediately
            ? int.tryParse(_noticePeriodController.text)
            : null,
      );
      context.read<JobPreferencesCubit>().savePreferences(entity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobPreferencesCubit, JobPreferencesState>(
      listener: (context, state) {
        if (state is JobPreferencesSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Preferences saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is JobPreferencesLoaded) {
          setState(() {
            _initializeValues(state.preferences);
          });
        }
      },
      builder: (context, state) {
        // Move loading check to button or overlay if you want to keep form visible
        if (state is JobPreferencesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. REUSED: DynamicListSection
                // Replaces _buildLabel, _roleController, _buildRoleInput, and the Chips Wrap
                DynamicListSection(
                  title: 'Target Role',
                  hintText: 'e.g., Software Engineer',
                  items: _targetRoles,
                  onChanged: (values) => setState(() => _targetRoles = values),
                ),

                const Gap(24),
                _buildLabel('Salary Expectations'),
                // Note: Kept custom _buildSalaryRow because your CustomTextField
                // doesn't support suffixText ('/mo') or Widget prefixes currently.
                _buildSalaryRow(),

                const Gap(24),
                _buildLabel('Work Environment'),
                _buildSelectionChips(
                  options: _availableWorkModes,
                  selectedValues: _workModes,
                  onSelect: (val) => setState(() {
                    _workModes.contains(val)
                        ? _workModes.remove(val)
                        : _workModes.add(val);
                  }),
                ),

                const Gap(24),
                _buildLabel('Employment Type'),
                _buildSelectionChips(
                  options: _availableEmpTypes,
                  selectedValues: _employmentTypes,
                  onSelect: (val) => setState(() {
                    _employmentTypes.contains(val)
                        ? _employmentTypes.remove(val)
                        : _employmentTypes.add(val);
                  }),
                ),

                const Gap(24),
                buildSwitchTile(
                  title: 'Open to relocation',
                  value: _canRelocate,
                  onChanged: (val) => setState(() => _canRelocate = val),
                ),

                const Gap(16),
                buildSwitchTile(
                  title: 'Can start immediately',
                  value: _canStartImmediately,
                  onChanged: (val) =>
                      setState(() => _canStartImmediately = val),
                ),

                if (_canStartImmediately) ...[
                  const Gap(24),
                  CustomTextField(
                    label: 'Notice Period',
                    hint: 'e.g., 2 weeks',
                    controller: _noticePeriodController,
                  ),
                ],

                const Gap(40),

                SavingButton(
                  text: 'Save Preferences',
                  //pass isLoading: state is JobPreferencesLoading here
                  onPressed: _onSave,
                  backgroundColor: const Color(0xFF4285F4),
                  padding: EdgeInsets.zero,
                  height: 50,
                ),
                const Gap(24),
              ],
            ),
          ),
        );
      },
    );
  }
  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5F6368), // Dark grey
        ),
      ),
    );
  }

  Widget _buildSalaryRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Minimum Salary",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Gap(4),
              TextFormField(
                controller: _minSalaryController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  hint: 'e.g., 5,000',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '\$',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  suffixText: '/mo', // Per month request
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Maximum Salary",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Gap(4),
              TextFormField(
                controller: _maxSalaryController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  hint: 'e.g., 8,000',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '\$',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  suffixText: '/mo',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionChips({
    required List<String> options,
    required List<String> selectedValues,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((option) {
        final isSelected = selectedValues.contains(option);
        return InkWell(
          onTap: () => onSelect(option),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF4285F4)
                    : Colors.grey.shade300,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF4285F4)
                    : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // Simulating the card look from the screenshot
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF3C4043),
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF4285F4),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? hint,
    Widget? prefixIcon,
    String? suffixText,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: prefixIcon,
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4285F4), width: 1.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
