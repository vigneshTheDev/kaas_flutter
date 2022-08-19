import 'package:flutter/material.dart';

import 'package:kaas/auth/google.dart';
import 'package:kaas/firestore/transaction_doc.dart';
import 'package:kaas/repo/transaction_repo.dart';
import 'package:kaas/shared_components/text_input.dart';
import 'package:kaas/shared_components/y_space.dart';

import 'transaction_item.dart';
import '../entities/parsed_description.dart';

class TransactionInput extends StatefulWidget {
  final Function(TransactionDoc) onSubmit;
  final String accountId;
  const TransactionInput({
    Key? key,
    required this.onSubmit,
    required this.accountId,
  }) : super(key: key);

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final ParsedDescription _description = ParsedDescription();
  final _controller = TextEditingController();
  final _transactionRepo = const TransactionRepo();
  bool _creating = false;

  _createTransaction() async {
    final userId = await getUserId();
    if (userId == null) {
      return;
    }

    final transactionDoc = TransactionDoc(
      account: widget.accountId,
      description: _description,
      amount: _description.amount,
      time: DateTime.now().microsecondsSinceEpoch,
      tags: _description.segments
          .where((element) => element.isTag)
          .map((e) => e.string)
          .toList(),
    );

    _setCreating(true);
    _transactionRepo
        .createTransaction(
          userId,
          transactionDoc,
        )
        .then((value) {
          _controller.clear();
          widget.onSubmit(transactionDoc);
        })
        .catchError((err) {})
        .whenComplete(() {
          _setCreating(false);
        });
  }

  _setCreating(bool creating) {
    setState(() {
      _creating = creating;
    });
  }

  @override
  Widget build(BuildContext context) {
    var loading = _creating;
    return Column(
      children: [
        TextInput(
          controller: _controller,
          hintText: 'E.g. Milk 4 #Groceries',
          label: 'Add Transaction',
          button: IconButton(
            iconSize: 16,
            onPressed: loading
                ? null
                : () {
                    _createTransaction();
                  },
            icon: const Icon(Icons.check),
            splashRadius: 17,
          ),
          onChanged: (value) {
            setState(() {
              _description.updateDescription(value);
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
              description: _description,
              placeholder: 'E.g. Milk 4 #Groceries',
            ),
          ),
        )
      ],
    );
  }
}
