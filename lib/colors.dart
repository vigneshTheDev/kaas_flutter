import 'package:flutter/material.dart';

Color yellowText = const Color.fromRGBO(125, 101, 8, 1);
Color yellowLight = const Color.fromRGBO(254, 239, 202, 1);
Color yellowHighlight = const Color.fromRGBO(240, 175, 50, 0.2);

Color incomeSourceBgColor = const Color.fromRGBO(255, 229, 163, 1);
Color incomeSourceFgColor = yellowText;
Color accountBgColor = const Color.fromRGBO(183, 229, 255, 1);
Color accountFgColor = const Color.fromRGBO(6, 81, 114, 1);
Color expenseBgColor = const Color.fromRGBO(255, 168, 168, 1);
Color expenseFgColor = const Color.fromRGBO(49, 17, 29, 1);

LinearGradient yellowGradient = const LinearGradient(
  colors: [
    Color.fromRGBO(254, 222, 143, 1),
    Color.fromRGBO(254, 222, 143, 0.75),
    Color.fromRGBO(254, 222, 143, 1)
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0, 0.4, 1],
);
