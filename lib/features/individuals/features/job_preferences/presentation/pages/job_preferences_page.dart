import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/presentation/cubit/job_preferences_cubit.dart';
import 'package:graduation_project/features/individuals/features/job_preferences/presentation/pages/job_preferences_view.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';

class JobPreferencesPage extends StatelessWidget {
  const JobPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Job Preferences'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      // BlocListener handles the "Sync to UserCubit" logic
      body: BlocListener<JobPreferencesCubit, JobPreferencesState>(
        listener: (context, state) {
          if (state is JobPreferencesSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Preferences saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is JobPreferencesLoaded) {
            // SYNC BACK TO USER CUBIT
            context.read<UserCubit>().updateJobPreferences(state.preferences);
          } else if (state is JobPreferencesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const JobPreferencesView(),
      ),
    );
  }
}
