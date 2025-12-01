import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Note: Assuming AuthCubit imports are correctly managed
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';
import '../../../../core/exports/app_exports.dart';

class CompanyStatusWrapper extends StatelessWidget {
  const CompanyStatusWrapper({super.key});

  // (Static routing logic _handleRouting remains unchanged)
  static void _handleRouting(BuildContext context, CompanyState state) {
    if (state is CompanyStatusChecked) {
      final hasProfile = state.hasProfile;
      // hasPaid is hardcoded to true now

      if (!hasProfile) {
        context.goNamed('company-complete-profile');
      } else {
        context.goNamed('company-search');
      }
    } else if (state is CompanyError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status check failed: ${state.message}')),
      );
      context.go('/login');
    }
  }

  // Logic to safely dispatch the initial check event using the real user ID
  void _startStatusCheck(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    String? currentUserId;

    if (authState is AuthAuthenticated) {
      currentUserId = authState.user.id;
    }

    if (currentUserId != null && currentUserId.isNotEmpty) {
      // Dispatch event to the CompanyBloc
      context.read<CompanyBloc>().add(CheckCompanyStatusEvent(currentUserId));
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext buildContextAncestor) {
    // 🛑 SOLUTION: Use a Builder widget to get a new context (builderContext)
    // that is a descendant of the BlocProvider, allowing the lookup to succeed.
    return Builder(
      builder: (builderContext) {
        // 1. Dispatch the check event using the descendant context
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startStatusCheck(builderContext);
        });

        return Scaffold(
          body: BlocListener<CompanyBloc, CompanyState>(
            // 2. The listener uses the context from the Builder's child tree
            listener: (companyContext, companyState) {
              _handleRouting(companyContext, companyState);
            },
            child: BlocBuilder<CompanyBloc, CompanyState>(
              builder: (context, companyState) {
                if (companyState is CompanyInitial ||
                    companyState is CompanyLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Verifying account status...'),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
