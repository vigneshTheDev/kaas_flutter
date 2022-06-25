import 'package:flutter/material.dart';

class XPadding extends StatelessWidget {
  final Widget child;

  const XPadding({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
