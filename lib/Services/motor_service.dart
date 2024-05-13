import 'package:cloud_firestore/cloud_firestore.dart';

class MotorService {
  final CollectionReference motor =
      FirebaseFirestore.instance.collection('motor');

  // Create
  Future<void> addMotor(
      String namaMotor, int harga, String merk, var downloadUrl) {
    return motor.add({
      'namaMotor': namaMotor,
      'harga': harga,
      'merk': merk,
      'timestamp': Timestamp.now(),
      // add image
      "Image": downloadUrl.toString(),
      'isOrdered': false
    });
  }

  Stream<QuerySnapshot> getMotorStream() {
    final motorStream =
        motor.orderBy('timestamp', descending: true).snapshots();
    return motorStream;
  }

  Future<DocumentSnapshot> getMotorById(String docID) async {
    DocumentReference docRef = motor.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> deleteNote(String docID) {
    return motor.doc(docID).delete();
  }

  Future<void> updateMotor(String docID, String namaMotor, int harga,
      String merk, String imageUrl) async {
    DocumentReference docRef = motor.doc(docID);

    await docRef.update({
      'namaMotor': namaMotor,
      'harga': harga,
      'merk': merk,
      'Image': imageUrl,
    });
  }
}
