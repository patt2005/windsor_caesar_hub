import 'package:flutter/material.dart';

class ToggleButtonsPage extends StatefulWidget {
  const ToggleButtonsPage({super.key});

  @override
  _ToggleButtonsPageState createState() => _ToggleButtonsPageState();
}

class _ToggleButtonsPageState extends State<ToggleButtonsPage> {
  bool isButton1Pressed = false;
  bool isButton2Pressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isButton1Pressed = !isButton1Pressed;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isButton1Pressed ? Colors.yellow : Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('News'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isButton2Pressed = !isButton2Pressed;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isButton2Pressed ? Colors.yellow : Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Map'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
