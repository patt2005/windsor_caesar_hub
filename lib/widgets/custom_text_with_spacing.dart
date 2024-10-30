import 'package:flutter/material.dart';

class CustomTextWithSpacing extends StatelessWidget {
  final String title;
  final String description;

  const CustomTextWithSpacing({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
