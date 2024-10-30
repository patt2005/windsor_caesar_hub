import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/models/news.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class NewsInfoPage extends StatelessWidget {
  final News newsInfo;

  const NewsInfoPage({
    super.key,
    required this.newsInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.02,
              width: screenSize.width,
            ),
            Text(
              newsInfo.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              newsInfo.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
