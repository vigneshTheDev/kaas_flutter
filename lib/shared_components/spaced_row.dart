import 'package:flutter/material.dart';
import 'package:kaas/shared_components/x_space.dart';

class SpacedRow extends StatelessWidget {
  final List<Widget> children;
  final double space;
  const SpacedRow({Key? key, required this.children, this.space = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [children[0]];

    for (int i = 1; i < children.length; i++) {
      widgets.addAll([XSpace(space), children[i]]);
    }

    return Row(
      children: widgets,
    );
  }
}
