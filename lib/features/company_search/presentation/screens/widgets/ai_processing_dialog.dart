// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';

class AiProcessingDialog extends StatefulWidget {
  const AiProcessingDialog({super.key});

  @override
  State<AiProcessingDialog> createState() => _AiProcessingDialogState();
}

class _AiProcessingDialogState extends State<AiProcessingDialog> {
  int _textIndex = 0;
  // The texts that will cycle while the AI loads
  final List<String> _loadingTexts = [
    "Analyzing your request...",
    "Extracting key skills...",
    "Identifying location & roles...",
    "Matching with best talent...",
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        setState(() {
          _textIndex = (_textIndex + 1) % _loadingTexts.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff356fed).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Color(0xff356fed),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "AI Smart Search",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Smooth text transition
            SizedBox(
              height: 30, // Fixed height to prevent jumping
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  _loadingTexts[_textIndex],
                  key: ValueKey<int>(_textIndex),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}