import 'package:flutter/material.dart';

import 'package:kaas/auth/google.dart';
import 'package:kaas/firestore/transaction_doc.dart';
import 'package:kaas/pages/add_transactions_page/components/account_list.dart';
import 'package:kaas/pages/add_transactions_page/components/transaction_item.dart';
import 'package:kaas/pages/create_account_page/create_account.dart';
import 'package:kaas/repo/transaction_repo.dart';
import 'package:kaas/firestore/account_doc.dart';
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
  final _transactionRepo = const TransactionRepo();

  Future<List<AccountDoc>?>? _accounts;
  List<TransactionDoc>? _transactions;
  AccountDoc? _selectedAccount;
  bool _loadingTransactions = false;

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
      _accounts = accounts;
    });

    final data = await accounts;

    if (data == null) {
      return;
    }

    _selectAccount(data[0]);
    _loadTransactions();
  }

  _loadTransactions() async {
    final userId = await getUserId();
    final account = _selectedAccount?.id;
    if (userId == null || account == null) {
      return;
    }

    final transactions = await _transactionRepo
        .listTransactions(userId, account)
        .whenComplete(() => _loadingTransactions = false);
    setState(() {
      _transactions = transactions;
    });
  }

  _gotoCreateAccount() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const CreateAccountPage();
        },
      ),
    );
    _loadAccounts();
  }

  _selectAccount(AccountDoc account) {
    setState(() {
      _selectedAccount = account;
      _loadingTransactions = true;
    });
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final accounts = _accounts;
    final transactions = _transactions;
    final selectedAccount = _selectedAccount;

    return Scaffold(
      appBar: const SimpleAppBar(title: 'Transactions'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YSpace(16),
            if (accounts != null)
              XPadding(
                child: AccountList(
                  accounts: accounts,
                  selectedAccount: _selectedAccount,
                  onChange: (a) => _selectAccount(a),
                  loadAccounts: () => _loadAccounts(),
                  onCreateAccount: () => _gotoCreateAccount(),
                ),
              ),
            const YSpace(16),
            if (selectedAccount != null)
              XPadding(
                child: TransactionInput(
                  accountId: selectedAccount.id!,
                  onSubmit: (value) {
                    _loadTransactions();
                  },
                ),
              ),
            const YSpace(16),
            if (_loadingTransactions)
              const Center(child: CircularProgressIndicator()),
            if (!_loadingTransactions && transactions != null)
              ...(transactions
                  .map(
                    (e) => TransactionItem(
                      description: e.description,
                      transactionDate: e.dateString,
                    ),
                  )
                  .toList()),
            if (!_loadingTransactions &&
                transactions != null &&
                transactions.isEmpty)
              const Center(child: Text('No transactions found')),
          ],
        ),
      ),
    );
  }
}
