import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/pages/navigation_page.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';
import '../models/onboarding_info.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              _pageController.animateToPage(
                onboardingPages.length - 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingPages.length,
        itemBuilder: (context, index) {
          final page = onboardingPages[index];
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: page.onRight
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        page.imageAssetPath,
                        width: screenSize.height * 0.2,
                        height: screenSize.height * 0.28,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          page.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: () async {
                            if (index < onboardingPages.length - 1) {
                              await _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationPage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            minimumSize: Size(double.infinity,
                                MediaQuery.of(context).size.height * 0.08),
                            elevation: 8,
                            shadowColor: Colors.grey.withOpacity(0.5),
                          ),
                          child: const Text("Next"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
