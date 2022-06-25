import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kaas/colors.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  const SimpleAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: yellowLight,
      elevation: 0,
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: yellowText),
          textAlign: TextAlign.start),
      centerTitle: false,
    );
  }
}
