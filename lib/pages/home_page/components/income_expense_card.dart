import 'package:flutter/material.dart';
import 'package:kaas/shared_components/card.dart';

class IncomeExpenseCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  const IncomeExpenseCard(
      {Key? key,
      required this.label,
      required this.value,
      required this.icon,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KaasCard(
      child: Column(children: [
        const SizedBox(
          height: 34,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                  color: color, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 6,
            ),
            Icon(
              icon,
              size: 16,
              color: color,
            )
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF555555)),
        ),
        const SizedBox(
          height: 6,
        )
      ]),
    );
  }
}
