import 'package:flutter/material.dart';
import 'package:kaas/firestore/account_doc.dart';
import 'package:kaas/pages/add_transactions_page/components/pill.dart';
import 'package:kaas/shared_components/spaced_row.dart';

import 'empty_accounts_list.dart';

class AccountList extends StatelessWidget {
  final Future<List<AccountDoc>?> accounts;
  final AccountDoc? selectedAccount;
  final ValueChanged<AccountDoc> onChange;
  final VoidCallback onCreateAccount;
  final VoidCallback loadAccounts;

  const AccountList({
    Key? key,
    required this.accounts,
    required this.onChange,
    this.selectedAccount,
    required this.onCreateAccount,
    required this.loadAccounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AccountDoc>?>(
        future: accounts,
        builder: (context, snapshot) {
          final loading = snapshot.connectionState == ConnectionState.active;
          if (loading) {
            return const Center(
              child: Text("Loading..."),
            );
          }

          final error = snapshot.error?.toString();
          if (error != null) {
            return Column(
              children: [
                Text(error),
                ElevatedButton(
                  onPressed: loadAccounts,
                  child: const Text('Reload'),
                )
              ],
            );
          }

          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return EmptyAccountsList(onCreate: () {
              loadAccounts();
            });
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SpacedRow(
              children: [
                ...data.map(
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
        });
  }
}
