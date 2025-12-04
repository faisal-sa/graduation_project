import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showCustomDatePicker({
  required BuildContext context,
  required DateTime? initialDate,
  required Function(DateTime) onDateChanged,
}) async {
  await showModalBottomSheet(
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
              initialDateTime: initialDate ?? DateTime.now(),
              mode: CupertinoDatePickerMode.monthYear,
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          ),
        ],
      ),
    ),
  );
}
