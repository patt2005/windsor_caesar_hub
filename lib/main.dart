import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';
import 'pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(fontFamily: "Inter"),
      home: const OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
