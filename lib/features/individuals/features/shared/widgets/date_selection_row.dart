import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/custom_date_picker.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/date_box.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/form_label.dart';

class DateSelectionRow extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentlyWorking;
  final ValueChanged<DateTime?> onStartDateChanged;
  final ValueChanged<DateTime?> onEndDateChanged;

  const DateSelectionRow({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.isCurrentlyWorking,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormLabel("Start Date"),
              GestureDetector(
                onTap: () => showCustomDatePicker(
                  context: context,
                  initialDate: startDate,
                  onDateChanged: onStartDateChanged,
                ),
                child: DateBox(date: startDate, placeholder: "Select"),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormLabel("End Date"),
              GestureDetector(
                onTap: isCurrentlyWorking
                    ? null
                    : () => showCustomDatePicker(
                        context: context,
                        initialDate: endDate,
                        onDateChanged: onEndDateChanged,
                      ),
                child: DateBox(
                  date: endDate,
                  placeholder: "Select",
                  isDisabled: isCurrentlyWorking,
                  isTextPresent: isCurrentlyWorking,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
