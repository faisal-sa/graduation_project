import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/presentation/cubit/skills_languages_cubit.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/presentation/cubit/skills_languages_state.dart';

// Assuming you have these imports from your project structure
// import 'package:your_project/bloc/skills_languages_cubit.dart';
// import 'package:your_project/service_locator.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<SkillsLanguagesCubit>()..loadProfile(),
      child: Scaffold(
        backgroundColor: const Color(
          0xFFF5F7FA,
        ), // Light background for contrast
        appBar: AppBar(
          title: const Text("Edit Skills & Languages"),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocConsumer<SkillsLanguagesCubit, SkillsLanguagesState>(
          listener: (context, state) {
            if (state is SkillsLanguagesError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is SkillsLanguagesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SkillsLanguagesLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // --- SKILLS SECTION ---
                    _SectionCard(
                      title: "My Skills",
                      items: state.skillsLanguages.skills,
                      hintText: "Add a new skill...",
                      onAdd: (value) {
                        context.read<SkillsLanguagesCubit>().addSkill(value);
                      },
                      onDelete: (item) {
                        // Assuming your Cubit has a remove method
                        context.read<SkillsLanguagesCubit>().removeSkill(item);
                      },
                    ),

                    const SizedBox(height: 16),

                    // --- LANGUAGES SECTION ---
                    _SectionCard(
                      title: "My Languages",
                      items: state.skillsLanguages.languages,
                      hintText: "Add a new language...",
                      onAdd: (value) {
                        context.read<SkillsLanguagesCubit>().addLanguage(value);
                      },
                      onDelete: (item) {
                        // Assuming your Cubit has a remove method
                        context.read<SkillsLanguagesCubit>().removeLanguage(
                          item,
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// Reusable Widget for both Skills and Languages cards
class _SectionCard extends StatefulWidget {
  final String title;
  final List<dynamic> items; // List of Strings
  final String hintText;
  final Function(String) onAdd;
  final Function(String) onDelete;

  const _SectionCard({
    required this.title,
    required this.items,
    required this.hintText,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onAdd(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),

          // Wrap for Chips
          if (widget.items.isNotEmpty)
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.items.map<Widget>((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD), // Light blue background
                    borderRadius: BorderRadius.circular(20), // Stadium shape
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.toString(),
                        style: const TextStyle(
                          color: Color(0xFF1565C0), // Dark blue text
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      // Optional: Add X icon for deletion if desired
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => widget.onDelete(item),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: 20),

          // Custom Input Field
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6), // Gray background for input
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _handleSubmit(),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _handleSubmit,
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color(0xFF5F6D7E),
                    size: 28,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
