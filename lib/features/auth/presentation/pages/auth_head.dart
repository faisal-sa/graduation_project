import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/auth/presentation/pages/login_tab.dart';
import 'package:graduation_project/features/auth/presentation/pages/signup_tab.dart';

// ===============================================================
// AUTH TABS UI
// ===============================================================
class AuthHead extends StatelessWidget {
  const AuthHead({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 40),
                // ================= TAB BAR =================
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7FB),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xFFE5E7EB)),
                  ),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Login'),
                      Tab(text: 'Sign Up'),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // ================= TAB BODY =================
                Expanded(
                  child: TabBarView(
                    children: [const LoginTab(), const SignupTab()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
