import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/core/router/router.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => BlocProvider(
        create: (context) => serviceLocator<AuthCubit>(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
