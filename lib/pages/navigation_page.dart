import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/pages/main2.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        activeColor: Colors.yellow,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.question_circle),
            label: 'Initiatives',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.group),
            label: 'Voluntarism',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return const Main2();
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return const Main2();
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return const Main2();
              },
            );
          default:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return const Main2();
              },
            );
        }
      },
    );
  }
}