import 'package:flutter/material.dart';

import '../colors.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;
  const BottomNavigation(this.currentIndex, {Key? key, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          ThemeData(splashColor: yellowLight, highlightColor: yellowHighlight),
      child: Container(
        decoration: BoxDecoration(gradient: yellowGradient),
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          onTap: (int i) {
            onChange(i);
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt),
              label: 'Quick Actions',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.transparent,
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
