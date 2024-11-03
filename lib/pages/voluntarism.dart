import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/models/voluntarism.text.dart';
import 'package:windsor_caesar_hub/pages/voluntarism_field.dart';

class MyCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MyCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 8,
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Positioned(
                bottom: 8,
                right: 8,
                child: Icon(Icons.arrow_forward_ios, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Voluntarism extends StatelessWidget {
  const Voluntarism({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Voluntarism",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VoluntarismField(),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          itemCount: windsorvoluntarism.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            return MyCard(
              title: windsorvoluntarism[i].title,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      title: windsorvoluntarism[i].title,
                      description: windsorvoluntarism[i].description,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;
  final String description;

  const DetailsPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
