import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionDoc {
  final String? id;
  final String account;
  final String description;
  final double amount;
  final int time;
  final List<String> tags;

  const TransactionDoc({
    this.id,
    required this.account,
    required this.description,
    required this.amount,
    required this.time,
    required this.tags,
  });

  factory TransactionDoc.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TransactionDoc(
      id: snapshot.id,
      account: data?['account'],
      description: data?['description'],
      amount: data?['amount'],
      time: data?['time'],
      tags: data?['tags'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {"time": time, "amount": amount, "tags": tags, "account": account};
  }
}
