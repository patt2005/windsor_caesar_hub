import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/pages/main2.dart';
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
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingPages.length,
        itemBuilder: (context, index) {
          final page = onboardingPages[index];
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      onPressed: () {
                        if (index < onboardingPages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Main2()),
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
              if (index < onboardingPages.length - 1)
                Positioned(
                  top: 40,
                  right: 15,
                  child: TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(onboardingPages.length - 1);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
