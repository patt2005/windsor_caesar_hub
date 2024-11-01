import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class VoluntarismField extends StatefulWidget {
  const VoluntarismField({super.key});

  @override
  State<VoluntarismField> createState() => _VoluntarismFieldState();
}

class _VoluntarismFieldState extends State<VoluntarismField> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  final List<String> _names = ["Name", "Location", "Date", "Number of people"];
  final List<String> _hints = ["required", "required", "required", "Answer"];

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
              controller: _controllers[index],
              decoration: InputDecoration(
                labelText: _names[index], // Main label
                border: InputBorder.none,
              ),
            ),
          ),
          Text(
            _hints[index], // Hint text
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
          labelText: "Brief description of the event",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildSecondField() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Text(
          "Done",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Voluntarism",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Generăm câmpurile de text
            ...List.generate(4, (index) => buildTextField(index)),
            // Adăugăm câmpul de descriere
            buildDescriptionField(),
            // Adăugăm butonul "Done"
            buildSecondField(),
          ],
        ),
      ),
    );
  }
}
