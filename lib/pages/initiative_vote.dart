import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/initiatives.text.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class InitiativeVote extends StatefulWidget {
  final Initiativestext initiativestext;

  const InitiativeVote({
    super.key,
    required this.initiativestext,
  });

  @override
  State<InitiativeVote> createState() => _InitiativeVoteState();
}

class _InitiativeVoteState extends State<InitiativeVote> {
  int? _selectedVariantIndex;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.05),
            Container(
              width: screenSize.width,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: screenSize.width,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Initiative",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        Text(
                          widget.initiativestext.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.initiativestext.variants.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedVariantIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: _selectedVariantIndex == index
                                ? Colors.amber.shade100
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.initiativestext.variants[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedVariantIndex == index
                                        ? Colors.black
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              Icon(
                                _selectedVariantIndex == index
                                    ? CupertinoIcons.circle_filled
                                    : CupertinoIcons.circle,
                                color: _selectedVariantIndex == index
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
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
                      if (_selectedVariantIndex != null) {
                        final provider =
                            Provider.of<AppManager>(context, listen: false);
                        provider
                            .markInitiativeAsAnswered(widget.initiativestext);
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
          ],
        ),
      ),
    );
  }
}
