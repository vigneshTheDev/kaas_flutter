import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDoc {
  final String? id;
  final String name;
  final double initialBalance;
  final double balance;
  final String currency;

  const AccountDoc({
    this.id,
    required this.name,
    required this.initialBalance,
    required this.balance,
    required this.currency,
  });

  factory AccountDoc.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AccountDoc(
      id: snapshot.id,
      name: data?['name'],
      balance: data?['balance'],
      initialBalance: data?['initial_balance'],
      currency: data?['currency'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "balance": balance,
      "initial_balance": initialBalance,
      "currency": currency
    };
  }
}
