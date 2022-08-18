import 'package:cloud_firestore/cloud_firestore.dart';

class TypeSenseConfigDoc {
  final String ipAddress;
  const TypeSenseConfigDoc(this.ipAddress);

  factory TypeSenseConfigDoc.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, _) {
    final data = snapshot.data();
    return TypeSenseConfigDoc(data?["address"]);
  }

  dynamic toFireStore() {
    return {};
  }
}
