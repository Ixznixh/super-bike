import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/superbike_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection Reference
  CollectionReference<Map<String, dynamic>> get _bikesRef =>
      _db.collection('superbikes');

  // Real-time Stream of Superbikes uploaded by community
  Stream<List<Superbike>> get bikesStream {
    return _bikesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Superbike.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // Upload a New Superbike to Firestore Cloud
  Future<void> uploadSuperbike(Superbike bike) async {
    await _bikesRef.doc(bike.id).set(bike.toMap());
  }
}
