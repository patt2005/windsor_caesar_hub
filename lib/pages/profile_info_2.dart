import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/pages/profile_info_3.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

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

  Widget buildTextField(int index) {
    return Consumer<AppManager>(
      builder: (context, value, child) => Container(
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
              index == 0
                  ? value.userInfo!.Email
                  : value.userInfo!.phone.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<AppManager>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
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
            onTap: () async {
              await Navigator.push(
                  context,
                  CupertinoPageRoute(
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
              width: screenSize.width,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<AppManager>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: size.width * 0.25,
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                FileImage(File(provider.userInfo!.imagepath)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${value.userInfo!.firstname} ${value.userInfo!.lastname}",
                      style: const TextStyle(
                          fontSize: 22,
                          fontFamily: "Inter",
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        value.userInfo!.about,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
          ),
        ],
      ),
    );
  }
}
