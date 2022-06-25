import 'package:flutter/material.dart';
import 'package:kaas/colors.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), gradient: yellowGradient),
      child: Text(
        '25,00,000',
        style: TextStyle(fontSize: 22, color: yellowText),
      ),
    );
  }
}
