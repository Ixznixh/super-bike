import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/superbike_data.dart';
import '../models/superbike_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection Reference
  CollectionReference<Map<String, dynamic>> get _bikesRef =>
      _db.collection('superbikes');

  // Real-time Stream of Superbikes uploaded & stored in Firebase
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

  // Sync and Seed All 50 Flagship Superbikes to Firebase Firestore asynchronously
  void syncAllBikesToFirebase() {
    Future.microtask(() async {
      try {
        final batch = _db.batch();
        for (var bike in SuperbikeData.initialBikes) {
          batch.set(_bikesRef.doc(bike.id), bike.toMap(), SetOptions(merge: true));
        }
        await batch.commit().timeout(const Duration(seconds: 3));
      } catch (_) {}
    });
  }
}
