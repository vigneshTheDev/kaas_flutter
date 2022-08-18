import 'package:flutter/material.dart';
import 'package:kaas/shared_components/text_input.dart';
import 'package:kaas/shared_components/y_space.dart';

import 'transaction_item.dart';
import '../entities/parsed_description.dart';

class TransactionInput extends StatefulWidget {
  const TransactionInput({Key? key}) : super(key: key);

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  ParsedDescription description = ParsedDescription();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInput(
          hintText: 'E.g. Milk 4 #Groceries',
          label: 'Add Transaction',
          button: IconButton(
            iconSize: 16,
            onPressed: () {},
            icon: const Icon(Icons.check),
            splashRadius: 17,
          ),
          onChanged: (value) {
            setState(() {
              description.updateDescription(value);
            });
          },
        ),
        const YSpace(8),
        Opacity(
          opacity: 0.6,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: TransactionItem(
              description: description,
            ),
          ),
        )
      ],
    );
  }
}
