import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaas/firestore/typesense_config_doc.dart';

class TypeSenseConfigRepo {
  Future<TypeSenseConfigDoc?> getConfig() async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection('type_sense').doc('ip').withConverter(
        fromFirestore: TypeSenseConfigDoc.fromFireStore,
        toFirestore: (TypeSenseConfigDoc t, _) => t.toFireStore());
    final docSnap = await docRef.get();
    final doc = docSnap.data();
    return doc;
  }
}
