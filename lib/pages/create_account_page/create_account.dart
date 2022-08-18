import 'package:flutter/material.dart';

import 'package:kaas/auth/google.dart';
import 'package:kaas/shared_components/currency_picker.dart';
import 'package:kaas/shared_components/simple_app_bar.dart';
import 'package:kaas/firestore/account_doc.dart';
import 'package:kaas/repo/account_repo.dart';
import 'package:kaas/shared_components/text_input.dart';
import 'package:kaas/shared_components/y_space.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final AccountRepo _accountRepo = const AccountRepo();

  String _name = '';
  double _balance = 0;
  String _currency = '';

  _showMessage(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createAccount(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (_name == '') {
      _showMessage(context, "Please enter the name");
      return;
    }

    if (_currency == '') {
      _showMessage(context, "Please enter Currency");
      return;
    }

    final user = await getUserId();

    if (user == null) {
      return;
    }

    final account = AccountDoc(
      name: _name,
      initialBalance: _balance,
      balance: _balance,
      currency: _currency,
    );
    await _accountRepo.createAccount(user, account);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: "Create Account",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextInput(
              hintText: 'E.g. Primary Savings A/C',
              label: 'Name',
              onChanged: (name) {
                _name = name;
              },
            ),
            const YSpace(16),
            TextInput(
              hintText: 'E.g. 10000',
              label: 'Balance',
              onChanged: (balance) {
                _balance = double.parse(balance);
              },
            ),
            const YSpace(16),
            CurrencyPicker(
              label: 'Currency',
              onChanged: (currency) {
                _currency = currency['code'];
              },
            ),
            const YSpace(16),
            ElevatedButton(
              onPressed: () {
                _createAccount(context);
              },
              child: const Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
