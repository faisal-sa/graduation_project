import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/custom_text_field.dart';
import 'package:graduation_project/features/individuals/features/shared/widgets/form_label.dart';

class DynamicListSection extends StatefulWidget {
  final String title;
  final String hintText;
  final List<String> items;
  final ValueChanged<List<String>> onChanged;

  const DynamicListSection({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  State<DynamicListSection> createState() => _DynamicListSectionState();
}

class _DynamicListSectionState extends State<DynamicListSection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final newList = List<String>.from(widget.items)..add(text);
      widget.onChanged(newList);
      _controller.clear();
    }
  }

  void _removeItem(int index) {
    final newList = List<String>.from(widget.items)..removeAt(index);
    widget.onChanged(newList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(widget.title),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _controller,
                hint: widget.hintText,
              ),
            ),
            SizedBox(width: 8.w),
            IconButton.filled(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(backgroundColor: Colors.black87),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (widget.items.isNotEmpty)
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: widget.items
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
                            onTap: () => _removeItem(e.key),
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
          ),
      ],
    );
  }
}
