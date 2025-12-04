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
<<<<<<< HEAD
=======
            SizedBox(height: 12.h),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? "Edit Experience" : "Add Experience",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Scrollable Form Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                // Ensure this widget uses WorkExperienceFormCubit to set values
                child: const _WorkExperienceFormBody(),
              ),
            ),

            // Sticky Bottom Button
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child:
                      BlocBuilder<
                        WorkExperienceFormCubit,
                        WorkExperienceFormState
                      >(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.status == FormStatus.loading
                                ? null
                                : () => context
                                      .read<WorkExperienceFormCubit>()
                                      .submitForm(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                            child: state.status == FormStatus.loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isEditing
                                        ? "Save Changes"
                                        : "Save Experience",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        },
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkExperienceFormBody extends StatefulWidget {
  const _WorkExperienceFormBody();

  @override
  State<_WorkExperienceFormBody> createState() =>
      _WorkExperienceFormBodyState();
}

class _WorkExperienceFormBodyState extends State<_WorkExperienceFormBody> {
  final _resController = TextEditingController();

  void _showDatePicker(BuildContext context, bool isStart) {
    final cubit = context.read<WorkExperienceFormCubit>();
    final initial = isStart
        ? (cubit.state.startDate ?? DateTime.now())
        : (cubit.state.endDate ?? DateTime.now());

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => SizedBox(
        height: 250.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: initial,
                mode: CupertinoDatePickerMode.monthYear,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (val) => isStart
                    ? cubit.startDateChanged(val)
                    : cubit.endDateChanged(val),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label("Job Title"),
        _TextField(
          hint: "e.g. Senior Product Designer",
          onChanged: (v) =>
              context.read<WorkExperienceFormCubit>().jobTitleChanged(v),
        ),
        SizedBox(height: 16.h),

        _Label("Company"),
        _TextField(
          hint: "e.g. Google",
          icon: Icons.business,
          onChanged: (v) =>
              context.read<WorkExperienceFormCubit>().companyNameChanged(v),
        ),
        SizedBox(height: 16.h),

        _Label("Employment Type"),
        BlocBuilder<WorkExperienceFormCubit, WorkExperienceFormState>(
          buildWhen: (p, c) => p.employmentType != c.employmentType,
          builder: (context, state) => DropdownButtonFormField<String>(
            initialValue: state.employmentType,
            decoration: _inputDeco(hint: "Select"),
>>>>>>> origin/payments_new
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
