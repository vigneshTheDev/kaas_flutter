import 'package:flutter/material.dart';

class KaasCard extends StatelessWidget {
  final Widget child;
  const KaasCard({Key? key, required Widget this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF0F0F0),
      ),
      child: child,
    );
  }
}
