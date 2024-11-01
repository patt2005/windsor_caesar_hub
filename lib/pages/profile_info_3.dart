import 'package:flutter/material.dart';

class ProfileInfo3 extends StatefulWidget {
  const ProfileInfo3({super.key});

  @override
  State<ProfileInfo3> createState() => _ProfileInfo3State();
}

class _ProfileInfo3State extends State<ProfileInfo3> {
  final List<TextEditingController> _controllers2 =
      List.generate(4, (index) => TextEditingController());
  final List<String> _names1 = [
    "Email",
    "Phone",
    "Your name",
    "Your last name"
  ];
  final List<String> _hints1 = [
    "arnold@gmail.com",
    "+99999999999",
    "Arnold",
    "Arnold"
  ];
  Widget buildTextFieldDescription() {
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
          labelText: "Exemplu",
          border: InputBorder.none,
        ),
      ),
    );
  }

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
              controller: _controllers2[index],
              decoration: InputDecoration(
                labelText: _names1[index],
                border: InputBorder.none,
              ),
            ),
          ),
          Text(
            _hints1[index],
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Done",
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
          child: SingleChildScrollView(
            child: Column(
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
                ...List.generate(4, (index) => buildTextField(index)),
                buildTextFieldDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
