import 'package:flutter/material.dart';
import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/onbording/intro_text.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //==================  Skip Button  ===================
            //
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.go('/auth');
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //==================  Skip Button End  ===================
            //
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: introText.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = introText[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          page['icon'] as IconData,
                          size: 120,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page['title']!,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: 300,
                          child: Text(
                            page['description']!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // ==================  Contant Page End  =================== //
                  );
                },
              ),
            ),
            //==================  Dots ○ ○ ● ○  ===================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(introText.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: _currentPage == index ? 60 : 30,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            //==================  NEXT BUTTOM  ===================
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onTap: () {
                  if (_currentPage == introText.length - 1) {
                    context.go('/auth');
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _currentPage == introText.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
