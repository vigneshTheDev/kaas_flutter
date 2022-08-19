import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaas/pages/add_transactions_page/entities/parsed_description.dart';
import 'package:intl/intl.dart';

class TransactionDoc {
  final String? id;
  final String account;
  final ParsedDescription description;
  final double amount;
  final int time;
  final List<String> tags;

  final DateFormat _dateFormatter = DateFormat.MMMd();
  String dateString = '';

  TransactionDoc({
    this.id,
    required this.account,
    required this.description,
    required this.amount,
    required this.time,
    required this.tags,
  }) {
    dateString = _dateFormatter
        .format(DateTime.fromMillisecondsSinceEpoch((time / 1000).round()));
  }

  factory TransactionDoc.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TransactionDoc(
      id: snapshot.id,
      account: data?['account'],
      description: ParsedDescription(description: data?['description']),
      amount: data?['amount'],
      time: data?['time'],
      tags: <String>[...data?['tags'].map((t) => t.toString())],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "time": time,
      "amount": amount,
      "tags": tags,
      "description": description.description,
      "account": account
    };
  }
}
