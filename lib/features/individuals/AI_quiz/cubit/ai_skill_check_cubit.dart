import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/AI_quiz/cubit/ai_skill_check_state.dart';
import 'package:graduation_project/features/individuals/AI_quiz/models/quiz_question.dart';
import 'package:graduation_project/features/individuals/AI_quiz/models/skill_category_result.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/main.dart';

class AiSkillCheckCubit extends Cubit<AiSkillCheckState> {
  // Assuming you inject your Gemini model wrapper here
  // final GenerativeModel model; 
  
  AiSkillCheckCubit() : super(AiSkillCheckInitial());

  List<QuizQuestion> _currentQuestions = [];

  Future<void> generateQuiz(UserEntity user) async {
    emit(AiSkillCheckLoading());

    try {
      // 1. Build Rich Context from UserEntity
      final jobTitle = user.jobTitle.isNotEmpty
          ? user.jobTitle
          : "Professional";
      
      final skills = user.skills.isNotEmpty
          ? user.skills.take(10).join(", ")
          : "General Professional Skills";

      final recentExperience = user.workExperiences.isNotEmpty
          ? user.workExperiences
                .take(2)
                .map((e) => "${e.jobTitle} at ${e.companyName}")
                .join(", ")
          : "No specific recent work history";

      final education = user.educations.isNotEmpty
          ? user.educations
                .map((e) => "${e.degreeType} in ${e.fieldOfStudy}")
                .join(", ")
          : "No specific education listed";

      // 2. Enhanced Prompt Engineering
      final prompt = '''
        You are a senior technical recruiter and domain expert. 
        Create a technical skill assessment quiz for a candidate with the following profile:
        - Target Role: $jobTitle
        - Key Skills: $skills
        - Recent Experience: $recentExperience
        - Education: $education
        
        Generate 5 multiple-choice questions.
        Rules:
        1. Questions should be scenario-based or technical, not just definitions.
        2. Adjust difficulty based on the profile (if they have Senior in title, make it hard).
        3. Cover different categories relevant to the skills provided (e.g., if they have Flutter, ask about State Management).
        
        Return valid JSON ONLY (no markdown formatting, no ```json tags):
        [
          {
            "question": "Question text?",
            "options": ["A", "B", "C", "D"],
            "correctIndex": 0,
            "category": "Category Name (e.g. Architecture, Syntax, Optimization)"
          }
        ]
      ''';

      // 3. Call AI (Pseudo-code for your implementation)
      // final content = [Content.text(prompt)];
      // final response = await model.generateContent(content);
      
      // MOCK RESPONSE FOR DEMO (Replace with actual AI call)
      await Future.delayed(
        const Duration(seconds: 4),
      ); // Simulate network for loader
      final mockJson =
          '''
      [
        {
          "question": "In the context of ${user.skills.isNotEmpty ? user.skills.first : 'this role'}, which design pattern best handles complex state changes?",
          "options": ["Singleton", "Observer", "Factory", "Decorator"],
          "correctIndex": 1,
          "category": "Architecture"
        },
        {
          "question": "When optimizing for performance in ${jobTitle}, what is the highest priority?",
          "options": ["Code comments", "Memory management", "Variable naming", "File structure"],
          "correctIndex": 1,
          "category": "Optimization"
        },
        {
          "question": "Based on your experience with $recentExperience, how would you handle a database deadlock?",
          "options": ["Restart server", "Implement retry logic with backoff", "Ignore it", "Increase RAM"],
          "correctIndex": 1,
          "category": "Backend"
        },
        {
          "question": "Which principle is NOT part of SOLID?",
          "options": ["Single Responsibility", "Open/Closed", "Loose Typing", "Interface Segregation"],
          "correctIndex": 2,
          "category": "Best Practices"
        },
        {
          "question": "For a $jobTitle, which metric matters most for user retention?",
          "options": ["Lines of code", "App startup time", "Commit frequency", "Colors used"],
          "correctIndex": 1,
          "category": "Analytics"
        }
      ]
      ''';
      
      // Parse JSON (Add error handling for real AI responses)
      final List<dynamic> data = jsonDecode(mockJson);
      _currentQuestions = data.map((e) => QuizQuestion.fromMap(e)).toList();

      emit(AiSkillCheckQuestionsLoaded(_currentQuestions));

    } catch (e) {
      emit(AiSkillCheckError("Error generating quiz: ${e.toString()}"));
    }
  }

  void submitQuizAnswers(List<int?> userAnswers) {
    if (_currentQuestions.isEmpty) return;

    int correctCount = 0;
    Map<String, List<bool>> categoryMap = {};

    for (int i = 0; i < _currentQuestions.length; i++) {
      final question = _currentQuestions[i];
      final isCorrect = userAnswers[i] == question.correctIndex;
      
      if (isCorrect) correctCount++;

      if (!categoryMap.containsKey(question.category)) {
        categoryMap[question.category] = [];
      }
      categoryMap[question.category]!.add(isCorrect);
    }

    final totalScore = ((correctCount / _currentQuestions.length) * 100).round();

    final breakdown = categoryMap.entries.map((entry) {
      final totalInCat = entry.value.length;
      final correctInCat = entry.value.where((v) => v).length;
      final percentage = ((correctInCat / totalInCat) * 100).round();

      String status;
      if (percentage >= 90) status = "Strong";
      else if (percentage >= 70) status = "Proficient";
      else status = "Needs Improvement";

      return SkillCategoryResult(
        category: entry.key,
        scorePercentage: percentage,
        status: status,
      );
    }).toList();

    emit(AiSkillCheckCompleted(totalScore: totalScore, breakdown: breakdown));
  }
}