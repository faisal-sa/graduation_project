import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/form/work_experience_form_cubit.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/form/work_experience_form_state.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/list/work_experience_list_cubit.dart';
import 'package:intl/intl.dart';

class AddWorkExperienceModal extends StatelessWidget {
  final bool isEditing;
  const AddWorkExperienceModal({super.key, this.isEditing = false});

  static void show(BuildContext context, WorkExperience? experience) {
    final listCubit = context.read<WorkExperienceListCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) {
        final formCubit = serviceLocator.get<WorkExperienceFormCubit>();

        if (experience != null) {
          formCubit.initializeForEdit(experience);
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: formCubit),
            BlocProvider.value(value: listCubit),
          ],
          child: AddWorkExperienceModal(isEditing: experience != null),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkExperienceFormCubit, WorkExperienceFormState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Navigator.pop(context);

          context.read<WorkExperienceListCubit>().loadExperiences();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing ? "Experience Updated" : "Experience Added",
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? "Error"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
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
            value: state.employmentType,
            decoration: _inputDeco(hint: "Select"),
            items: [
              'Full-time',
              'Part-time',
              'Contract',
              'Freelance',
            ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => context
                .read<WorkExperienceFormCubit>()
                .employmentTypeChanged(v!),
          ),
        ),
        SizedBox(height: 16.h),

        _Label("Location"),
        _TextField(
          hint: "e.g. New York, USA",
          icon: Icons.location_on_outlined,
          onChanged: (v) =>
              context.read<WorkExperienceFormCubit>().locationChanged(v),
        ),
        SizedBox(height: 16.h),

        BlocBuilder<WorkExperienceFormCubit, WorkExperienceFormState>(
          buildWhen: (p, c) => p.isCurrentlyWorking != c.isCurrentlyWorking,
          builder: (context, state) => Row(
            children: [
              Checkbox(
                value: state.isCurrentlyWorking,
                activeColor: Colors.black87,
                onChanged: (v) => context
                    .read<WorkExperienceFormCubit>()
                    .currentWorkingChanged(v ?? false),
              ),
              Text(
                "I am currently working here",
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Label("Start Date"),
                  BlocBuilder<WorkExperienceFormCubit, WorkExperienceFormState>(
                    buildWhen: (p, c) => p.startDate != c.startDate,
                    builder: (context, state) => GestureDetector(
                      onTap: () => _showDatePicker(context, true),
                      child: _DateBox(
                        date: state.startDate,
                        placeholder: "Select",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Label("End Date"),
                  BlocBuilder<WorkExperienceFormCubit, WorkExperienceFormState>(
                    buildWhen: (p, c) =>
                        p.endDate != c.endDate ||
                        p.isCurrentlyWorking != c.isCurrentlyWorking,
                    builder: (context, state) => GestureDetector(
                      onTap: state.isCurrentlyWorking
                          ? null
                          : () => _showDatePicker(context, false),
                      child: _DateBox(
                        date: state.endDate,
                        placeholder: "Select",
                        isDissabled: state.isCurrentlyWorking,
                        isTextPresent: state.isCurrentlyWorking,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        _Label("Responsibilities"),
        Row(
          children: [
            Expanded(
              child: _TextField(
                controller: _resController,
                hint: "Add key achievement...",
              ),
            ),
            SizedBox(width: 8.w),
            IconButton.filled(
              onPressed: () {
                context.read<WorkExperienceFormCubit>().addResponsibility(
                  _resController.text,
                );
                _resController.clear();
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(backgroundColor: Colors.black87),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        BlocBuilder<WorkExperienceFormCubit, WorkExperienceFormState>(
          buildWhen: (p, c) => p.responsibilities != c.responsibilities,
          builder: (context, state) {
            if (state.responsibilities.isEmpty) return const SizedBox.shrink();
            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: state.responsibilities
                    .asMap()
                    .entries
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 6,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                e.value,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                            InkWell(
                              onTap: () => context
                                  .read<WorkExperienceFormCubit>()
                                  .removeResponsibility(e.key),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
        // Add extra padding for scroll comfort
        SizedBox(height: 100.h),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER WIDGETS
// -----------------------------------------------------------------------------

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
    ),
  );
}

class _TextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const _TextField({
    this.hint = '',
    this.icon,
    this.onChanged,
    this.controller,
  });
  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(fontSize: 14.sp),
    decoration: _inputDeco(hint: hint, icon: icon),
  );
}

class _DateBox extends StatelessWidget {
  final DateTime? date;
  final String placeholder;
  final bool isDissabled;
  final bool isTextPresent;
  const _DateBox({
    this.date,
    required this.placeholder,
    this.isDissabled = false,
    this.isTextPresent = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDissabled ? Colors.grey[100] : Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isTextPresent
                ? "Present"
                : (date == null
                      ? placeholder
                      : DateFormat('MMM yyyy').format(date!)),
            style: TextStyle(
              color: isTextPresent
                  ? Colors.green
                  : (date == null ? Colors.grey[400] : Colors.black87),
              fontWeight: isTextPresent ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
          if (!isTextPresent)
            Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey[500]),
        ],
      ),
    );
  }
}

InputDecoration _inputDeco({required String hint, IconData? icon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
    prefixIcon: icon != null
        ? Icon(icon, size: 20.sp, color: Colors.grey[500])
        : null,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Colors.black87, width: 1.5),
    ),
  );
}
