import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/pages/profile_info_3.dart';

class ProfileInfo2 extends StatefulWidget {
  const ProfileInfo2({super.key});

  @override
  State<ProfileInfo2> createState() => _ProfileInfo2State();
}

class _ProfileInfo2State extends State<ProfileInfo2> {
  final List<TextEditingController> _controllers3 =
      List.generate(2, (index) => TextEditingController());

  final List<String> _names2 = [
    "Email",
    "Phone",
  ];
  final List<String> hints2 = [
    "arnold@gmail.com",
    "+9999999999",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildTextField(int index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controllers3[index], // Corectat: _controllers3
                decoration: InputDecoration(
                  labelText: _names2[index], // Main label
                  border: InputBorder.none,
                ),
              ),
            ),
            Text(
              hints2[index], // Hint text
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileInfo3(),
                  ));
            },
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              "images/Frame 237.png",
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: size.width * 0.25,
                      height: size.height * 0.25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("images/Ellipse 2.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Arnold Arnorld",
                    style: TextStyle(
                        fontSize: 22, fontFamily: "Inter", color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(2, (index) => buildTextField(index)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
