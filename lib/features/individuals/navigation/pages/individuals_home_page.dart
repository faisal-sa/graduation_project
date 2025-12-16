import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';

class IndividualsHomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const IndividualsHomePage({super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      // appBar: const _AppBar(),
      body: navigationShell,

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border(top: BorderSide(color: Colors.grey.shade200)),
      //   ),
      //   child: BottomNavigationBar(
      //     currentIndex: navigationShell.currentIndex,
      //     onTap: _goBranch,
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     selectedItemColor: AppColors.bluePrimary,
      //     unselectedItemColor: AppColors.textSub,
      //     selectedFontSize: 12,
      //     unselectedFontSize: 12,
      //     type: BottomNavigationBarType.fixed,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.bar_chart),
      //         label: 'Insights',
      //       ),
      //       //to be added oneday!
      //       // BottomNavigationBarItem(
      //       //   icon: Icon(Icons.chat_bubble_outline),
      //       //   label: 'Chats',
      //       // ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person_outline),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.go('/auth');
        }
      },
      child: AppBar(
        backgroundColor: Color(0XFFf1f5f9),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.blueLight,
              child: Icon(Icons.person, color: AppColors.bluePrimary),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOutUser();
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}
