import 'package:flutter/material.dart';
import 'package:kaas/auth/google.dart';
import 'package:kaas/pages/add_transactions_page/components/account_list.dart';
import 'package:kaas/pages/create_account_page/create_account.dart';
import 'package:kaas/shared_components/x_space.dart';
import 'package:kaas/firestore/account_doc.dart';
import 'package:kaas/pages/add_transactions_page/components/empty_accounts_list.dart';
import 'package:kaas/pages/add_transactions_page/components/pill.dart';
import 'package:kaas/repo/account_repo.dart';
import 'package:kaas/shared_components/x_padding.dart';
import 'package:kaas/shared_components/y_space.dart';
import 'package:kaas/shared_components/simple_app_bar.dart';

import 'components/transaction_input.dart';

class AddTransactionsPage extends StatefulWidget {
  const AddTransactionsPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionsPage> createState() => _AddTransactionsPageState();
}

class _AddTransactionsPageState extends State<AddTransactionsPage> {
  final _accountRepo = const AccountRepo();

  Future<List<AccountDoc>?>? _accountsFuture;
  AccountDoc? _selectedAccount;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  _loadAccounts() async {
    final userId = await getUserId();
    if (userId == null) {
      return;
    }

    final accounts = _accountRepo.listAccounts(userId);
    setState(() {
      _accountsFuture = accounts.then((value) {
        if (value != null) {
          setState(() {
            _selectedAccount = value[0];
          });
        }
        return value;
      });
    });
  }

  _createAccount() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const CreateAccountPage();
        },
      ),
    );
    _loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'Transactions'),
        body: FutureBuilder(
          future: _accountsFuture,
          builder: (_, AsyncSnapshot<List<AccountDoc>?> snapshot) {
            if (snapshot.error != null) {
              return Column(
                children: [
                  const Text("Something went wrong!"),
                  ElevatedButton(
                    onPressed: _loadAccounts,
                    child: const Text('Reload'),
                  )
                ],
              );
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: Text("Loading..."),
              );
            }

            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return EmptyAccountsList(onCreate: () {
                _loadAccounts();
              });
            }

            final accounts = snapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YSpace(16),
                if (accounts != null)
                  XPadding(
                    child: AccountList(
                      accounts: accounts,
                      onChange: (a) {
                        setState(() {
                          _selectedAccount = a;
                        });
                      },
                      onCreateAccount: () {
                        _createAccount();
                      },
                      selectedAccount: _selectedAccount,
                    ),
                  ),
                const YSpace(16),
                const XPadding(
                  child: TransactionInput(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
