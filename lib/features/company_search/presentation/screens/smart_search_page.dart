


// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/company_search/presentation/blocs/bloc/search_bloc.dart';
import 'package:graduation_project/features/company_search/presentation/screens/widgets/ai_processing_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SmartSearchPage extends StatefulWidget {
  const SmartSearchPage({super.key});

  @override
  State<SmartSearchPage> createState() => _SmartSearchPageState();
}

class _SmartSearchPageState extends State<SmartSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  
  final GeminiService _geminiService = serviceLocator.get<GeminiService>();

  Future<void> _performAiSearch(BuildContext context) async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (ctx) => const AiProcessingDialog(),
    );

    try {
      final prompt = '''
      You are a recruitment search assistant. Analyze this search query: "$query".
      
      Extract the following criteria and return a strictly valid JSON object. 
      Do not include Markdown formatting (like ```json).
      
      Fields to extract:
      - "skills": list of strings (e.g. ["Flutter", "Python"])
      - "location": string (e.g. "Riyadh")
      - "jobTitle": string matching one of: 'Mobile Developer', 'Backend Developer', 'Frontend Developer', 'UI/UX Designer', 'Data Scientist' (or null if no match)
      - "workModes": list of strings matching: 'Remote', 'Hybrid', 'On-Site'
      - "languages": list of strings (e.g. ["Arabic", "English"])
      - "canRelocate": boolean (true if query implies willingness to move, else null)
      
      If a field is not mentioned, set it to null.
      ''';

      final response = await _geminiService.generateContent(
        prompt: prompt,
        enforceJson: true,
      );

      if (mounted) Navigator.of(context).pop();

      if (response != null) {
        String cleanJson = response.replaceAll('```json', '').replaceAll('```', '').trim();
        final Map<String, dynamic> data = jsonDecode(cleanJson);

        if (!mounted) return;
        context.read<SearchBloc>().add(
              PerformSearchEvent(
                location: data['location'] as String?,
                skills: (data['skills'] as List?)?.map((e) => e.toString()).toList(),
                jobTitle: data['jobTitle'] as String?,
                workModes: (data['workModes'] as List?)?.map((e) => e.toString()).toList(),
                languages: (data['languages'] as List?)?.map((e) => e.toString()).toList(),
                canRelocate: data['canRelocate'] as bool?,
                employmentTypes: null,
                targetRoles: null,
              ),
            );

        context.pushNamed(
          'company-search-results',
          extra: context.read<SearchBloc>(),
        );
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop(); 
      
      debugPrint("AI Search Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not understand query. Try Advanced Search.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOutUser();
              context.go("/auth");
            },
            icon: Icon(Icons.exit_to_app, size: 24.r),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 40),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _performAiSearch(context),
                    decoration: InputDecoration(
                      hintText: 'Describe who you are looking for...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: const Icon(Icons.auto_awesome, color: Color(0xff356fed)), 
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () => _performAiSearch(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff356fed),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: const Color(0xff356fed).withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.auto_awesome, size: 20),
                    label: const Text(
                      "Smart AI Search",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    context.pushNamed('company-search-advanced', extra: context.read<SearchBloc>());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Prefer manual filters? "),
                      Text(
                        "Advanced Search",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
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