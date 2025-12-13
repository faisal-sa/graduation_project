import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/domain/entities/certification.dart';
import 'package:intl/intl.dart';

class CertificationCard extends StatelessWidget {
  final Certification certification;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CertificationCard({super.key, 
    required this.certification,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('MMM yyyy');

    String dateStr = "Issued ${fmt.format(certification.issueDate)}";
    if (certification.expirationDate != null) {
      dateStr =
          "${fmt.format(certification.issueDate)} - ${fmt.format(certification.expirationDate!)}";
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      certification.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      certification.issuingInstitution,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateStr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.blue[400],
                      size: 20.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.only(left: 8.w),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red[300],
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Attachments Indicator
          if (certification.credentialFile != null)
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 14.sp,
                      color: Colors.blue[700],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Credential Attached",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
