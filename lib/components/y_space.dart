import 'package:flutter/material.dart';

class YSpace extends StatelessWidget {
  final double space;
  const YSpace(this.space, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}
