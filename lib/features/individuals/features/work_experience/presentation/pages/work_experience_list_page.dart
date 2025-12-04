import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/individuals/features/work_experience/domain/entities/work_experience.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/work_experience_cubit.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/cubit/work_experience_state.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/widgets/add_work_experience_modal.dart';
import 'package:graduation_project/features/individuals/features/work_experience/presentation/widgets/experience_card.dart';

class WorkExperienceListPage extends StatelessWidget {
  const WorkExperienceListPage({super.key});

  Future<void> _handleExperienceResult(
    BuildContext context,
    WorkExperience? result, {
    bool isUpdate = false,
  }) async {
    if (result != null && context.mounted) {
      if (isUpdate) {
        context.read<WorkExperienceCubit>().updateExperience(result);
      } else {
        context.read<WorkExperienceCubit>().addExperience(result);
      }
    }
  }

  Future<void> _openModal(BuildContext context, [WorkExperience? exp]) async {
    final result = await AddWorkExperienceModal.show(context, exp);
    if (context.mounted) {
      _handleExperienceResult(context, result, isUpdate: exp != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Work Experience',
          style: TextStyle(color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () => _openModal(context),
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WorkExperienceCubit, WorkExperienceState>(
        builder: (context, state) {
          if (state.status == ListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? "Error loading data"),
            );
          }

          if (state.experiences.isEmpty) {
            return _EmptyExperienceView(onAdd: () => _openModal(context));
          }

          return ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemCount: state.experiences.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final exp = state.experiences[index];
              return ExperienceCard(
                experience: exp,
                onDelete: () => context
                    .read<WorkExperienceCubit>()
                    .deleteExperience(exp.id),
                onEdit: () => _openModal(context, exp),
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptyExperienceView extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyExperienceView({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 48.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text(
            "No experience listed",
            style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
          ),
          TextButton(
            onPressed: onAdd,
            child: const Text("Add your first role"),
          ),
        ],
      ),
    );
  }
}
