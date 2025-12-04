import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateBox extends StatelessWidget {
  final DateTime? date;
  final String placeholder;
  final bool isDisabled;
  final bool isTextPresent;

  const DateBox({
    super.key,
    this.date,
    required this.placeholder,
    this.isDisabled = false,
    this.isTextPresent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey[100] : Colors.white,
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
