// --- 1. THE MAIN SHELL ---
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/custom_date_picker.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/date_box.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/form_label.dart';

class BaseFormSheet extends StatelessWidget {
  final String title;
  final String submitLabel;
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;
  final Widget child;
  final bool isLoading;

  const BaseFormSheet({
    super.key,
    required this.title,
    required this.submitLabel,
    required this.onSubmit,
    required this.child,
    this.onCancel,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onCancel ?? () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),

          // Scrollable Form Body
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  child,
                  // Bottom padding to ensure content isn't hidden behind sticky button
                  SizedBox(height: 80.h),
                ],
              ),
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
                child: ElevatedButton(
                  onPressed: isLoading ? null : onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          submitLabel,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormFileUploadButton extends StatelessWidget {
  final String label;
  final PlatformFile? file;
  final String? existingUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const FormFileUploadButton({
    super.key,
    required this.label,
    required this.onTap,
    this.file,
    this.existingUrl,
    this.isSelected = false,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasContent =
        isSelected ||
        file != null ||
        (existingUrl != null && existingUrl!.isNotEmpty);

    String displayText = label;
    if (file != null) {
      //displayText = file!.path!.split(Platform.pathSeparator).last;
    } else if (hasContent && file == null) {
      displayText = "File Selected";
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: hasContent ? Colors.green.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: hasContent ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Icon(
                  hasContent ? Icons.check_circle : Icons.upload_file,
                  color: hasContent ? Colors.green : Colors.grey[500],
                  size: 20.sp,
                ),
                SizedBox(height: 4.h),
                Text(
                  displayText,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (hasContent && onClear != null)
              Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                  icon: Icon(Icons.close, size: 16.sp, color: Colors.red),
                  onPressed: onClear,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --- 3. REUSABLE DATE ROW ---
class FormDateRow extends StatelessWidget {
  final String startLabel;
  final DateTime? startDate;
  final ValueChanged<DateTime?> onStartChanged;

  final String endLabel;
  final DateTime? endDate;
  final ValueChanged<DateTime?> onEndChanged;
  final String endPlaceholder;

  const FormDateRow({
    super.key,
    required this.startLabel,
    required this.startDate,
    required this.onStartChanged,
    this.endLabel = "End Date",
    required this.endDate,
    required this.onEndChanged,
    this.endPlaceholder = "Select",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(startLabel), // Assuming FormLabel is global
              GestureDetector(
                onTap: () => showCustomDatePicker(
                  // Assuming global helper
                  context: context,
                  initialDate: startDate,
                  onDateChanged: onStartChanged,
                ),
                child: DateBox(
                  // Assuming global helper
                  date: startDate,
                  placeholder: "Select",
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
              FormLabel(endLabel),
              GestureDetector(
                onTap: () => showCustomDatePicker(
                  context: context,
                  initialDate: endDate,
                  onDateChanged: onEndChanged,
                ),
                child: DateBox(date: endDate, placeholder: endPlaceholder),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
