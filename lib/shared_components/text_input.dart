import 'package:flutter/material.dart';
import 'package:kaas/shared_components/y_space.dart';

class TextInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmitted;

  final String? hintText;
  final String? label;
  final Widget? button;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const TextInput({
    Key? key,
    this.hintText,
    this.label,
    this.button,
    this.focusNode,
    this.controller,
    this.onSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = this.label;

    const fillColor = Color(0xFFF9F9F9);
    const hintColor = Color(0xFFAAAAAA);

    const borderColor = Color(0xFFF0F0F0);
    const focusBorderColor = Color(0xFFC0C0C0);

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: borderColor),
    );
    var focusBorder = border.copyWith(
      borderSide: const BorderSide(color: focusBorderColor),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        const YSpace(2),
        Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Color(0xFF333333), fontSize: 12),
                focusNode: focusNode,
                controller: controller,
                onChanged: (value) {
                  onChanged(value);
                },
                onSubmitted: (_) {
                  final onSubmitted = this.onSubmitted;
                  if (onSubmitted != null) onSubmitted();
                },
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  hintText: hintText,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  hintStyle: const TextStyle(color: hintColor),
                  fillColor: fillColor,
                  border: border,
                  enabledBorder: border,
                  focusedBorder: focusBorder,
                ),
              ),
            ),
            if (button != null)
              SizedBox.square(
                dimension: 34,
                child: button,
              )
          ],
        )
      ],
    );
  }
}
