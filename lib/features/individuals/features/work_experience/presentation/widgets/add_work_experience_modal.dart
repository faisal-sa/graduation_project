import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/custom_text_field.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/form_label.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/shared_things.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/dynamic_list_section.dart';
import 'package:uuid/uuid.dart';

class AddWorkExperienceModal extends StatefulWidget {
  final WorkExperience? experience;

  const AddWorkExperienceModal({super.key, this.experience});

  static Future<WorkExperience?> show(
    BuildContext context,
    WorkExperience? experience,
  ) async {
    return await showModalBottomSheet<WorkExperience>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) => AddWorkExperienceModal(experience: experience),
    );
  }

  @override
  State<AddWorkExperienceModal> createState() => _AddWorkExperienceModalState();
}

class _AddWorkExperienceModalState extends State<AddWorkExperienceModal> {
  late TextEditingController _jobTitleController;
  late TextEditingController _companyNameController;
  late TextEditingController _locationController;

  String _employmentType = 'Full-time';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentlyWorking = false;
  List<String> _responsibilities = [];

  @override
  void initState() {
    super.initState();
    final exp = widget.experience;
    _jobTitleController = TextEditingController(text: exp?.jobTitle);
    _companyNameController = TextEditingController(text: exp?.companyName);
    _locationController = TextEditingController(text: exp?.location);

    if (exp != null) {
      _employmentType = exp.employmentType;
      _startDate = exp.startDate;
      _endDate = exp.endDate;
      _isCurrentlyWorking = exp.isCurrentlyWorking;
      _responsibilities = List.from(exp.responsibilities);
    }
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_jobTitleController.text.isEmpty ||
        _companyNameController.text.isEmpty ||
        _startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Missing required fields (Title, Company, Start Date)"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newExperience = WorkExperience(
      id: widget.experience?.id ?? const Uuid().v4(),
      jobTitle: _jobTitleController.text,
      companyName: _companyNameController.text,
      employmentType: _employmentType,
      location: _locationController.text,
      responsibilities: _responsibilities,
      startDate: _startDate!,
      endDate: _isCurrentlyWorking ? null : _endDate,
      isCurrentlyWorking: _isCurrentlyWorking,
    );

    Navigator.pop(context, newExperience);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.experience != null;

    return BaseFormSheet(
      title: isEditing ? "Edit Experience" : "Add Experience",
      submitLabel: isEditing ? "Save Changes" : "Save Experience",
      onSubmit: _submit,
      // BaseFormSheet handles the padding, scroll view, and sticky button
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel("Job Title"),
          CustomTextField(
            hint: "e.g. Senior Product Designer",
            controller: _jobTitleController,
          ),
          SizedBox(height: 16.h),

          const FormLabel("Company"),
          CustomTextField(
            hint: "e.g. Google",
            icon: Icons.business,
            controller: _companyNameController,
          ),
          SizedBox(height: 16.h),

          const FormLabel("Employment Type"),
          DropdownButtonFormField<String>(
            initialValue: _employmentType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            items: [
              'Full-time',
              'Part-time',
              'Contract',
              'Freelance',
            ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _employmentType = v!),
          ),
          SizedBox(height: 16.h),

          const FormLabel("Location"),
          CustomTextField(
            hint: "e.g. New York, USA",
            icon: Icons.location_on_outlined,
            controller: _locationController,
          ),
          SizedBox(height: 16.h),

          // Checkbox for Currently Working
          Row(
            children: [
              Checkbox(
                value: _isCurrentlyWorking,
                activeColor: Colors.black87,
                onChanged: (v) => setState(() {
                  _isCurrentlyWorking = v ?? false;
                  if (_isCurrentlyWorking) {
                    _endDate = null;
                  }
                }),
              ),
              Text(
                "I am currently working here",
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Reusable Date Row
          FormDateRow(
            startLabel: "Start Date",
            startDate: _startDate,
            onStartChanged: (d) => setState(() => _startDate = d),
            endLabel: "End Date",
            // If working, pass null to clear visual selection or keep _endDate if you want to remember it
            endDate: _isCurrentlyWorking ? null : _endDate,
            // Change placeholder if currently working
            endPlaceholder: _isCurrentlyWorking ? "Present" : "Select",
            // If currently working, prevent changing the end date
            onEndChanged: _isCurrentlyWorking
                ? (_) {}
                : (d) => setState(() => _endDate = d),
          ),
          SizedBox(height: 24.h),

          DynamicListSection(
            title: "Responsibilities",
            hintText: "Add key achievement...",
            items: _responsibilities,
            onChanged: (list) => setState(() => _responsibilities = list),
          ),
        ],
      ),
    );
  }
}
