import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';

class InsightsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InsightsAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.go('/auth');
        }
      },
      child: AppBar(
        backgroundColor: const Color(0XFFf1f5f9),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.go('/profile'),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.blueLight,
                child: Icon(
                  Icons.person,
                  color: AppColors.bluePrimary,
                  size: 24.r,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOutUser();
              },
              icon: Icon(Icons.exit_to_app, size: 24.r),
            ),
          ],
        ),
      ),
    );
  }
}
