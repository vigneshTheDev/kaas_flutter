import 'package:flutter/material.dart';

class XSpace extends StatelessWidget {
  final double space;
  const XSpace(this.space, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space);
  }
}
