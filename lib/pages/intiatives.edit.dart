import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/initiatives.text.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class Intiativesedit extends StatefulWidget {
  const Intiativesedit({super.key});

  @override
  State<Intiativesedit> createState() => _IntiativeseditState();
}

class _IntiativeseditState extends State<Intiativesedit> {
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());

  final List<String> _names = [
    "Name",
    "A variant",
    "B variant",
    "C variant",
    "D variant"
  ];
  final List<String> _hints = [
    "required",
    "required",
    "Answer",
    "required",
    "required"
  ];

  String? imageFilePath;

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
              controller: _controllers[index],
              decoration: InputDecoration(
                labelText: _names[index],
                border: InputBorder.none,
              ),
            ),
          ),
          Text(
            _hints[index],
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
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  5,
                  (index) => buildTextField(index),
                ),
                SizedBox(height: screenSize.height * 0.02),
                imageFilePath == null
                    ? GestureDetector(
                        onTap: () async {
                          final imagePicker = ImagePicker();
                          final image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            final cacheDir = await getTemporaryDirectory();
                            final timestamp = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            final filePath = path.join(
                                cacheDir.path, 'initiative_$timestamp.png');
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
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.upload_outlined,
                                  color: Colors.grey, size: 24),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Upload photo',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(imageFilePath!),
                          width: screenSize.width,
                          height: screenSize.height * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(height: screenSize.height * 0.02),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12)),
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    for (var controller in _controllers) {
                      if (controller.text.isEmpty) {
                        return;
                      }
                    }
                    if (imageFilePath != null) {
                      final provider =
                          Provider.of<AppManager>(context, listen: false);
                      provider.addInitiavtive(
                        Initiativestext(
                            name: _controllers[0].text,
                            variants: _controllers
                                .sublist(1)
                                .map((e) => e.text)
                                .toList(),
                            imageFilePath: imageFilePath!,
                            isOwn: true),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Done",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
