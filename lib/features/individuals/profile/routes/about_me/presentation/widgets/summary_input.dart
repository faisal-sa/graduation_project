import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/profile/routes/about_me/presentation/cubit/about_me_cubit.dart';

class SummaryInput extends StatelessWidget {
  const SummaryInput({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((AboutMeCubit c) => c.state);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        initialValue: state.summary,
        maxLines: 10,
        maxLength: 2000,
        onChanged: (val) => context.read<AboutMeCubit>().summaryChanged(val),
        style: const TextStyle(color: Color(0xFF334155), fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Write a brief summary...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
          counterStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
