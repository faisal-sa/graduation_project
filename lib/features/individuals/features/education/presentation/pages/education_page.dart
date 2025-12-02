import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/education/presentation/widgets/education_card.dart';

import '../cubit/education_cubit.dart';
import '../cubit/education_state.dart';
import '../widgets/add_education_modal.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Education',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await AddEducationModal.show(context, null);
              if (result != null && context.mounted) {
                context.read<EducationCubit>().addEducation(result);
              }
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
      body: BlocBuilder<EducationCubit, EducationState>(
        builder: (context, state) {
          if (state.status == ListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? "Error loading data"),
            );
          }

          final educations = state.educations;

          if (educations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 48.sp,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "No education listed",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                  ),
                  TextButton(
                    onPressed: () async {
                      final result = await AddEducationModal.show(
                        context,
                        null,
                      );
                      if (result != null && context.mounted) {
                        context.read<EducationCubit>().addEducation(result);
                      }
                    },
                    child: const Text("Add your education"),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemCount: educations.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final edu = educations[index];
              return EducationCard(
                education: edu,
                onDelete: () =>
                    context.read<EducationCubit>().deleteEducation(edu.id),
                onEdit: () async {
                  final result = await AddEducationModal.show(context, edu);
                  if (result != null && context.mounted) {
                    context.read<EducationCubit>().updateEducation(result);
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
