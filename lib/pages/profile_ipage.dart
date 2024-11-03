import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/user.dart';
import 'package:windsor_caesar_hub/pages/profile_info_2.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';
import 'package:path/path.dart' as path;

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
  final List<String> _hints1 = ["required", "optional", "required", "required"];

  String? imageFilePath;

  final TextEditingController _descriptionController = TextEditingController();

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
              keyboardType: index == 1
                  ? const TextInputType.numberWithOptions()
                  : TextInputType.text,
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
      child: TextField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: "A little about myself",
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppManager>(context, listen: false);
      imageFilePath = provider.userInfo?.imagepath;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppManager>(
      builder: (context, value, child) {
        if (value.userInfo == null) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    for (var controller in _controllers2) {
                      if (controller.text.isEmpty) {
                        return;
                      }
                    }
                    if (imageFilePath != null &&
                        _descriptionController.text.isNotEmpty) {
                      final provider =
                          Provider.of<AppManager>(context, listen: false);
                      provider.setUserInfo(
                        User(
                            firstname: _controllers2[2].text,
                            lastname: _controllers2[3].text,
                            Email: _controllers2[0].text,
                            phone: int.parse(_controllers2[1].text),
                            about: _descriptionController.text,
                            imagepath: imageFilePath!),
                      );
                    }
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
                      GestureDetector(
                        onTap: () async {
                          final imagePicker = ImagePicker();
                          final image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            final cacheDir = await getTemporaryDirectory();
                            final timestamp = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            final filePath = path.join(cacheDir.path,
                                'profile_picture_$timestamp.png');
                            final newFile = File(filePath);

                            if (await newFile.exists()) {
                              await newFile.delete();
                            }

                            await File(image.path).copy(filePath);
                            setState(() {
                              imageFilePath = filePath;
                            });
                          }
                        },
                        child: Container(
                          width: screenSize.height * 0.13,
                          height: screenSize.height * 0.13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                screenSize.height * 0.065),
                            image: imageFilePath != null
                                ? DecorationImage(
                                    image: FileImage(
                                      File(imageFilePath!),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: Colors.black12,
                          ),
                          child: imageFilePath == null
                              ? const Icon(
                                  CupertinoIcons.add,
                                  size: 30,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      ...List.generate(4, (index) => buildTextField(index)),
                      buildDescriptionField(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const ProfileInfo2();
      },
    );
  }
}
