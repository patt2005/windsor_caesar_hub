import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/pages/profile_info_2.dart';
import 'package:windsor_caesar_hub/pages/voluntarism_field.dart';

class ProfileIpage extends StatefulWidget {
  const ProfileIpage({super.key});

  @override
  State<ProfileIpage> createState() => _ProfileIpageState();
}

class _ProfileIpageState extends State<ProfileIpage> {
  final List<TextEditingController> _controllers2 =
      List.generate(4, (index) => TextEditingController());

  final List<String> _names1 = [
    "Email",
    "Phone",
    "Your name",
    "Your last name"
  ];
  final List<String> _hints1 = ["required", "optional", "required", "Required"];

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
              controller: _controllers2[index], // Corectat: _controllers2
              decoration: InputDecoration(
                labelText: _names1[index], // Main label
                border: InputBorder.none,
              ),
            ),
          ),
          Text(
            _hints1[index], // Hint text
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionField() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const TextField(
        maxLines: 5,
        decoration: InputDecoration(
          labelText: "A little about myself",
          border: InputBorder.none,
        ),
      ),
    );
  }

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
        leading: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileInfo2(),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ...List.generate(4,
                  (index) => buildTextField(index)), // Corectat: buildTextField
              buildDescriptionField(), // Afișează câmpul de descriere
            ],
          ),
        ),
      ),
    );
  }
}
