import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String text;

  const MyCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ),
            Positioned(
              top: 100,
              left: 8,
              child: Text(
                text,
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
    );
  }
}

class Initiatives extends StatelessWidget {
  const Initiatives({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Initiatives",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: const [
            MyCard(text: 'Name'),
            MyCard(text: 'Name'),
            MyCard(text: 'Your Name'),
            MyCard(text: 'Your Name'),
          ],
        ),
      ),
    );
  }
}
