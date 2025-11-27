import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class CompanyBookmarksPage extends StatelessWidget {
  const CompanyBookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CompanyBloc>();

    // عند بناء الصفحة يتم جلب البيانات مرة واحدة
    final current = bloc.state;
    if (current is CompanyLoaded) {
      bloc.add(GetCompanyBookmarksEvent(current.company.id));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('⭐ المرشحين المفضلين'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompanyBookmarksLoaded) {
            final bookmarks = state.bookmarks;

            if (bookmarks.isEmpty) {
              return const Center(
                child: Text(
                  'لم يتم إضافة أي مرشحين بعد.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final item = bookmarks[index];
                final profile = item['profiles'] ?? {};

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person_outline),
                    ),
                    title: Text(profile['full_name'] ?? 'مرشح غير معروف'),
                    subtitle: Text(
                      '${profile['skills'] ?? 'بدون مهارات'}\n${profile['city'] ?? 'مدينة غير معروفة'}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }

          if (state is CompanyError) {
            return Center(
              child: Text(
                'حدث خطأ: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(child: Text('لا توجد بيانات لعرضها.'));
        },
      ),
    );
  }
}
