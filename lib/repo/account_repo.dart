import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaas/firestore/account_doc.dart';
import 'package:kaas/utils/future_data.dart';

class AccountRepo {
  const AccountRepo();

  DocumentReference _getUserDocRef(String uid) {
    final instance = FirebaseFirestore.instance;

    final ref = instance.collection('users').doc(uid);
    return ref;
  }

  CollectionReference<AccountDoc> _getAccountCollectionRef(
      DocumentReference userDoc) {
    return userDoc.collection('accounts').withConverter(
          fromFirestore: AccountDoc.fromFirestore,
          toFirestore: (AccountDoc u, _) {
            return u.toFirestore();
          },
        );
  }

  DocumentReference<AccountDoc> _getAccountDocRef(DocumentReference userDoc) {
    return userDoc.collection('accounts').doc().withConverter(
        fromFirestore: AccountDoc.fromFirestore,
        toFirestore: (AccountDoc doc, _) {
          return doc.toFirestore();
        });
  }

  Future<List<AccountDoc>?> listAccounts(String uid) async {
    final userDocRef = _getUserDocRef(uid);
    final accountCollectionRef = _getAccountCollectionRef(userDocRef);

    final docSnap = await accountCollectionRef.get();
    final accounts = docSnap.docs.map((e) => e.data()).toList();
    return accounts;
  }

  Future<void> createAccount(String uid, AccountDoc account) async {
    final userDocRef = _getUserDocRef(uid);
    final docRef = _getAccountDocRef(userDocRef);
    await docRef.set(account);
  }
}
