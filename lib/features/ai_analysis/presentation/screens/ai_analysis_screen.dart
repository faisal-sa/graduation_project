import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/router/router.dart';
import 'package:graduation_project/features/ai_analysis/presentation/cubit/ai_analysis_state.dart';
import '../cubit/ai_analysis_cubit.dart';

class AiScoreCard extends StatelessWidget {
  final String candidateName;
  final String skills;
  final String currentJobTitle;
  final String targetJobTitle;

  const AiScoreCard({
    super.key,
    required this.candidateName,
    required this.skills,
    required this.currentJobTitle,
    required this.targetJobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AiAnalysisCubit>()
        ..analyzeProfile(
          candidateName: candidateName,
          skills: skills,
          jobTitle: currentJobTitle,
          targetJobTitle: targetJobTitle,
        ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.indigo.withOpacity(0.2)),
        ),
        child: BlocBuilder<AiAnalysisCubit, AiAnalysisState>(
          builder: (context, state) {
            if (state is AiLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(strokeWidth: 2),
                      SizedBox(height: 10),
                      Text(
                        "AI is analyzing compatibility...",
                        style: TextStyle(fontSize: 12, color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is AiLoaded) {
              final data = state.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.indigo),
                      const SizedBox(width: 8),
                      const Text(
                        "AI Match Score",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getScoreColor(data.score),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${data.score}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Text(
                    data.summary,
                    style: TextStyle(
                      color: Colors.grey[800],
                      height: 1.5,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (data.cons.isNotEmpty) ...[
                    const Text(
                      "⚠️ Missing Skills:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...data.cons.map(
                      (e) => Text("• $e", style: const TextStyle(fontSize: 12)),
                    ),
                  ],
                ],
              );
            }

            if (state is AiError) {
              final isQuotaError =
                  state.message.contains("quota") ||
                  state.message.contains("429");
              final isRetiredError = state.message.contains("retired");

              String displayMessage;
              if (isQuotaError) {
                displayMessage =
                    "Usage limit reached. Please wait ~30 seconds and try again.";
              } else if (isRetiredError) {
                displayMessage =
                    "Model version issue. Retrying with updated settings...";
              } else {
                displayMessage = "Analysis failed: ${state.message}";
              }

              return Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          displayMessage,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<AiAnalysisCubit>().analyzeProfile(
                          candidateName: candidateName,
                          skills: skills,
                          jobTitle: currentJobTitle,
                          targetJobTitle: targetJobTitle,
                        );
                      },
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text("Retry Analysis"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }
}
