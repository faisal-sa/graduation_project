import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_cubit.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_state.dart';
//this might be duplicated
class SaveBottomBar extends StatelessWidget {
  const SaveBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: BlocBuilder<AboutMeCubit, AboutMeState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: state.status == FormStatus.loading
                  ? null
                  : () => context.read<AboutMeCubit>().saveForm(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: state.status == FormStatus.loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
