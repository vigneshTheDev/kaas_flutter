import 'package:flutter/material.dart';
import 'package:kaas/auth/google.dart';
import 'package:kaas/firestore/account_doc.dart';
import 'package:kaas/repo/account_repo.dart';

class EmptyAccountsList extends StatelessWidget {
  final AccountRepo _accountRepo = const AccountRepo();

  final VoidCallback onCreate;

  const EmptyAccountsList({Key? key, required this.onCreate}) : super(key: key);

  _createAccount() async {
    final user = await getUserId();

    if (user == null) {
      return;
    }

    const account = AccountDoc(
      name: "Salary A/C",
      initialBalance: 88000,
      balance: 88000,
      currency: "INR",
    );
    await _accountRepo.createAccount(user, account);
    onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const Text("You have no accounts created"),
            ElevatedButton(
              onPressed: _createAccount,
              child: const Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
