import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/features/certifications/presentation/cubit/certification_cubit.dart';
import 'package:graduation_project/features/individuals/features/certifications/presentation/cubit/certification_state.dart';
import 'package:graduation_project/features/individuals/features/certifications/presentation/widgets/add_certification_modal.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/work_experience_state.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/widgets/custom_dashed_box.dart';
import 'package:intl/intl.dart';

class CertificationPage extends StatelessWidget {
  const CertificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleAddCertification() async {
      final result = await AddCertificationModal.show(context, null);
      if (result != null && context.mounted) {
        context.read<CertificationCubit>().addCertification(result);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Certifications',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: handleAddCertification,
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CertificationCubit, CertificationState>(
        builder: (context, state) {
          if (state.status == ListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? "Error loading data"),
            );
          }

          final list = state.certifications;

          if (list.isEmpty) {
            return Padding(
              padding: EdgeInsets.all(24.w),
              child: Center(
                child: EmptyStateView(
                  icon: Icons.workspace_premium_outlined,
                  message: "No certifications listed.\nTap to add one.",
                  onTap: handleAddCertification,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemCount: list.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final cert = list[index];
              return _CertificationCard(
                certification: cert,
                onDelete: () => context
                    .read<CertificationCubit>()
                    .deleteCertification(cert.id),
                onEdit: () async {
                  final result = await AddCertificationModal.show(
                    context,
                    cert,
                  );
                  if (result != null && context.mounted) {
                    context.read<CertificationCubit>().updateCertification(
                      result,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _CertificationCard extends StatelessWidget {
  final Certification certification;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const _CertificationCard({
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
