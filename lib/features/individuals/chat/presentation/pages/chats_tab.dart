import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/shared/user_cubit.dart';
import 'package:graduation_project/features/shared/user_state.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final isComplete = state.profileCompletion >= 0.8;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 40,
                  color: AppColors.bluePrimary,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "No Messages Yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  isComplete
                      ? "We'll notify you when a company reaches out."
                      : "Complete your profile to start matching with companies.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSub),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
