import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:windsor_caesar_hub/models/voluntarism.text.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
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
              controller: _controllers[index],
              decoration: InputDecoration(
                labelText: _names[index],
                border: InputBorder.none,
              ),
              readOnly: index == 2,
              keyboardType:
                  index == 3 ? TextInputType.number : TextInputType.text,
              onTap: index == 2 ? () => _selectDate(context, index) : null,
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

  Future<void> _selectDate(BuildContext context, int index) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
    setState(() {
      _controllers[index].text = formattedDate;
    });
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
          labelText: "Brief description of the event",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        final provider = Provider.of<AppManager>(context, listen: false);
        provider.addVoluntarism(
          Voluntarism(
            name: _controllers[0].text,
            location: _controllers[1].text,
            date: DateTime.parse(_controllers[2].text),
            numberOfPeople: int.tryParse(_controllers[3].text) ?? 0,
            description: _descriptionController.text,
          ),
        );
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
            ...List.generate(4, (index) => buildTextField(index)),
            buildDescriptionField(),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }
}
