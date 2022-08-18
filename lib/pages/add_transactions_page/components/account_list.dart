import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kaas/firestore/account_doc.dart';
import 'package:kaas/pages/add_transactions_page/components/pill.dart';
import 'package:kaas/shared_components/spaced_row.dart';
import 'package:kaas/shared_components/x_space.dart';

class AccountList extends StatelessWidget {
  final List<AccountDoc> accounts;
  final AccountDoc? selectedAccount;
  final ValueChanged<AccountDoc> onChange;
  final VoidCallback onCreateAccount;
  const AccountList({
    Key? key,
    required this.accounts,
    required this.onChange,
    this.selectedAccount,
    required this.onCreateAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SpacedRow(
        children: [
          ...accounts.map(
            (a) => Pill(
              text: a.name,
              selected: selectedAccount?.id == a.id,
              onTap: () {
                onChange(a);
              },
            ),
          ),
          Pill(
            onTap: () {
              onCreateAccount();
            },
            text: '+',
          )
        ],
      ),
    );
  }
}
