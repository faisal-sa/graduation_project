import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

const Color kPrimaryColor = Color(0xFF007BFF);
const Color kAccentColor = Color(0xFF00C7FF);
const Color kBackgroundColor = Color(0xFFF7F9FC);
const Color kCardColor = Colors.white;
const Color kTextColor = Color(0xFF333333);

class CompanySearchPage extends StatelessWidget {
  const CompanySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Arial',
          bodyColor: kTextColor,
          displayColor: kTextColor,
        ),
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(kPrimaryColor.value, <int, Color>{
            50: const Color(0xFFE3F2FD),
            100: const Color(0xFFBBDEFB),
            200: const Color(0xFF90CAF9),
            300: const Color(0xFF64B5F6),
            400: const Color(0xFF42A5F5),
            500: kPrimaryColor,
            600: const Color(0xFF1E88E5),
            700: const Color(0xFF1976D2),
            800: const Color(0xFF1565C0),
            900: const Color(0xFF0D47A1),
          }),
          accentColor: kAccentColor,
          backgroundColor: kBackgroundColor,
        ).copyWith(secondary: kAccentColor),
      ),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          backgroundColor: kCardColor,
          title: Row(
            children: [
              Image.asset('assets/icons/flutter.png', height: 32),
              const SizedBox(width: 10),
              const Text(
                'منصة التوظيف العكسي',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark, color: kPrimaryColor),
              tooltip: 'المفضلة',
              onPressed: () {
                context.pushNamed('company-bookmarks');
              },
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner, color: kPrimaryColor),
              tooltip: 'ماسح رمز الباحث',
              onPressed: () {
                context.pushNamed('company-qr');
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: kPrimaryColor),
              tooltip: 'الإعدادات',
              onPressed: () => context.pushNamed('company-settings'),
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن مهارة أو وظيفة...',
                    hintStyle: TextStyle(color: kTextColor.withOpacity(0.5)),
                    prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                  onSubmitted: (value) {
                    context.read<CompanyBloc>().add(
                      SearchCandidatesEvent(skill: value),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => context.pushNamed('company-advanced-search'),
                icon: const Icon(Icons.tune, color: kPrimaryColor, size: 20),
                label: const Text(
                  'بحث متقدم',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    );
                  } else if (state is CandidateResults) {
                    if (state.candidates.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/flutter.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'لم يتم العثور على مرشحين.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'حاول البحث بكلمات مفتاحية مختلفة أو استخدم البحث المتقدم.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextColor.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: state.candidates.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final candidate = state.candidates[index];
                        return CandidateCard(
                          candidate: candidate,
                          onBookmarkPressed: () {
                            final companyState = context
                                .read<CompanyBloc>()
                                .state;
                            if (companyState is CompanyLoaded) {
                              context.read<CompanyBloc>().add(
                                AddCandidateBookmarkEvent(
                                  candidate['id'] as String,
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  } else if (state is CompanyError) {
                    return Center(
                      child: Text(
                        'خطأ: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/flutter.png',
                          height: MediaQuery.of(context).size.height * 0.35,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'مرحبًا بك في منصة التوظيف العكسي!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'ابدأ البحث عن أفضل المواهب لشركتك الآن.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CandidateCard extends StatelessWidget {
  final Map<String, dynamic> candidate;
  final VoidCallback onBookmarkPressed;

  const CandidateCard({
    required this.candidate,
    required this.onBookmarkPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Material(
        color: kCardColor,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: kAccentColor.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: kPrimaryColor.withOpacity(0.8),
                size: 30,
              ),
            ),
            title: Text(
              candidate['full_name'] ?? 'مرشح غير معروف',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: kTextColor,
              ),
            ),
            subtitle: Text(
              candidate['skills'] ?? 'لا يوجد مهارات مسجلة',
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kTextColor.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            trailing: IconButton(
              tooltip: 'إضافة إلى المفضلة',
              icon: const Icon(
                Icons.bookmark_add_outlined,
                color: Color(0xFFFFA500),
              ),
              onPressed: onBookmarkPressed,
            ),
          ),
        ),
      ),
    );
  }
}
