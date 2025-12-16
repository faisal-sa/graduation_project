import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class CompanyOnboardingRouterPage extends StatefulWidget {
  const CompanyOnboardingRouterPage({super.key});

  @override
  State<CompanyOnboardingRouterPage> createState() =>
      _CompanyOnboardingRouterPageState();
}

class _CompanyOnboardingRouterPageState
    extends State<CompanyOnboardingRouterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInitialAuthStatus(context);
    });
  }

  void _checkInitialAuthStatus(BuildContext context) {
    final authState = context.read<AuthCubit>().state;

    if (authState.status == AuthStatus.authenticated &&
        authState.userId != null) {
      context.read<CompanyBloc>().add(
        CheckCompanyStatusEvent(authState.userId!),
      );
    } else if (authState.status != AuthStatus.loading) {
      context.go('/login');
    }
  }

  void _routeToNextStep(BuildContext context, CompanyStatusChecked state) {
    if (!state.hasProfile) {
      context.go('/company/complete-profile');
    }
    // }
    // ---------------------------
    else {
      context.go('/company/search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, authState) {
            if (authState.status == AuthStatus.authenticated &&
                authState.userId != null) {
              context.read<CompanyBloc>().add(
                CheckCompanyStatusEvent(authState.userId!),
              );
            } else if (authState.status == AuthStatus.unauthenticated) {
              context.go('/login');
            }
          },
        ),

        BlocListener<CompanyBloc, CompanyState>(
          listener: (context, companyState) {
            if (companyState is CompanyStatusChecked) {
              _routeToNextStep(context, companyState);
            } else if (companyState is CompanyError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Critical error checking profile status: ${companyState.message}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              context.go('/login');
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking company status...'),
            ],
          ),
        ),
      ),
    );
  }
}
