import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:windsor_caesar_hub/models/initiatives.text.dart';
import 'package:windsor_caesar_hub/pages/initiative_vote.dart';
import 'package:windsor_caesar_hub/pages/intiatives.edit.dart';
import 'package:windsor_caesar_hub/utils/app_manager.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class MyCard extends StatelessWidget {
  final Initiativestext initiativestext;

  const MyCard({
    super.key,
    required this.initiativestext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          initiativestext.isAnswered ? const Color(0xFFD3FFCC) : Colors.white,
      child: Container(
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenSize.height * 0.115,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: initiativestext.isOwn
                      ? FileImage(File(initiativestext.imageFilePath))
                      : AssetImage(initiativestext.imageFilePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              initiativestext.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (initiativestext.isOwn)
                  Text(
                    "Yours",
                    style: TextStyle(color: primaryColor),
                  ),
                const Spacer(),
                Image.asset(
                  "images/arrow.png",
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Initiatives extends StatelessWidget {
  const Initiatives({super.key});

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const Intiativesedit(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<AppManager>(
          builder: (context, value, child) => GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              for (int i = 0; i < value.initiatives.length; i++)
                GestureDetector(
                  onTap: () async {
                    if (!value.initiatives[i].isAnswered) {
                      await Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => InitiativeVote(
                              initiativestext: value.initiatives[i]),
                        ),
                      );
                    }
                  },
                  child: MyCard(initiativestext: value.initiatives[i]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
