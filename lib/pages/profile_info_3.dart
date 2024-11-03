import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/user.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';

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
  final TextEditingController _aboutController = TextEditingController();

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
      child: TextField(
        controller: _aboutController,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: "Information",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildTextField(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
            _names1[index],
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final provider = Provider.of<AppManager>(context, listen: false);
        _controllers2[0].text = provider.userInfo!.Email;
        _controllers2[1].text = provider.userInfo!.phone.toString();
        _controllers2[2].text = provider.userInfo!.firstname;
        _controllers2[3].text = provider.userInfo!.lastname;
        _aboutController.text = provider.userInfo!.about;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<AppManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              for (var controller in _controllers2) {
                if (controller.text.isEmpty) {
                  return;
                }
              }
              provider.setUserInfo(
                User(
                  firstname: _controllers2[2].text,
                  lastname: _controllers2[3].text,
                  Email: _controllers2[0].text,
                  phone: int.parse(_controllers2[1].text),
                  about: _aboutController.text,
                  imagepath: provider.userInfo!.imagepath,
                ),
              );
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: size.width * 0.25,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(File(provider.userInfo!.imagepath)),
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
