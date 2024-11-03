import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          child: Column(
            children: [
              ...List.generate(
                5,
                (index) => buildTextField(index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
