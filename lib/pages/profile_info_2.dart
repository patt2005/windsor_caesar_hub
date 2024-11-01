import 'package:flutter/material.dart';

class ProfileInfo2 extends StatefulWidget {
  const ProfileInfo2({super.key});

  @override
  State<ProfileInfo2> createState() => _ProfileInfo2State();
}

class _ProfileInfo2State extends State<ProfileInfo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Inter",
            fontSize: 16,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Edit",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: Column(),
      ),
    );
  }
}
