import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/presentation/cubit/certification_cubit.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/presentation/cubit/certification_state.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/presentation/widgets/add_certification_modal.dart';
import 'package:graduation_project/features/individuals/profile/routes/certifications/presentation/widgets/certification_card.dart';
import 'package:graduation_project/features/individuals/profile/routes/work_experience/presentation/cubit/work_experience_state.dart';
import 'package:graduation_project/features/individuals/profile/routes/work_experience/presentation/widgets/custom_dashed_box.dart';
import 'package:graduation_project/features/individuals/shared/user/presentation/cubit/user_cubit.dart';

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
      body: BlocListener<CertificationCubit, CertificationState>(
        listener: (context, state) {
          if (state.status == ListStatus.success ||
              (state.certifications.isNotEmpty &&
                  state.status != ListStatus.loading)) {
            serviceLocator.get<UserCubit>().updateCertificationsList(
              state.certifications,
            );
          }
        },
        child: BlocBuilder<CertificationCubit, CertificationState>(
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
                return CertificationCard(
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
      ),
    );
  }
}
