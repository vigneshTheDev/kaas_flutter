import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaas/firestore/transaction_doc.dart';

class TransactionRepo {
  const TransactionRepo();

  DocumentReference _getUserDocRef(String uid) {
    final instance = FirebaseFirestore.instance;

    final ref = instance.collection('users').doc(uid);
    return ref;
  }

  CollectionReference<TransactionDoc> _getAccountCollectionRef(
    DocumentReference userDoc,
  ) {
    return userDoc.collection('transactions').withConverter(
          fromFirestore: TransactionDoc.fromFirestore,
          toFirestore: (TransactionDoc t, _) {
            return t.toFirestore();
          },
        );
  }

  DocumentReference<TransactionDoc> _getTransactionDocRef(
      DocumentReference userDoc) {
    return userDoc.collection('transactions').doc().withConverter(
        fromFirestore: TransactionDoc.fromFirestore,
        toFirestore: (TransactionDoc doc, _) {
          return doc.toFirestore();
        });
  }

  Future<List<TransactionDoc>?> listTransactions(
    String uid,
    String account,
  ) async {
    final userDocRef = _getUserDocRef(uid);
    final accountCollectionRef = _getAccountCollectionRef(userDocRef);

    final docSnap =
        await accountCollectionRef.where("account", isEqualTo: account).get();
    final accounts = docSnap.docs.map((e) => e.data()).toList();
    return accounts;
  }

  Future<void> createTransaction(String uid, TransactionDoc transaction) async {
    final userDocRef = _getUserDocRef(uid);
    final docRef = _getTransactionDocRef(userDocRef);
    await docRef.set(transaction);
  }
}
