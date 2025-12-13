import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/core/usecasesAbstract/no_params.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';

class InsightsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InsightsAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          
              serviceLocator.get<AuthCubit>().signOut.call(NoParams());
              context.go("/");
            },
            icon: Icon(Icons.exit_to_app, size: 24.r),
          ),
        ],
      ),
    );
  }
}
