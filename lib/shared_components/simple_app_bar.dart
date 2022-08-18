import 'package:flutter/material.dart';
import 'package:kaas/colors.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool showBackButton;
  const SimpleAppBar(
      {Key? key, required this.title, this.showBackButton = false})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: yellowText,
              ),
            )
          : null,
      titleSpacing: showBackButton ? 0 : 16,
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
