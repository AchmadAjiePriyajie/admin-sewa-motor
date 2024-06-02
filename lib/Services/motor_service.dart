import 'package:admin_sewa_motor/models/motor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MotorService {
  final CollectionReference motor =
      FirebaseFirestore.instance.collection('motor');

  Future<void> addMotor(String namaMotor, int harga, String merk,
      var downloadUrl, int kapasitasMesin) {
    return motor.add(
      Motor(
        namaMotor: namaMotor,
        harga: harga,
        merk: merk,
        kapasitasMesin: kapasitasMesin,
        imageUrl: downloadUrl,
        isOrdered: false,
        timestamp: Timestamp.now(),
      ).toJson(),
    );
  }

  Stream<QuerySnapshot> getMotorStream() {
    final motorStream =
        motor.orderBy('timestamp', descending: false).snapshots();
    return motorStream;
  }

  Future<DocumentSnapshot> getMotorById(String docID) async {
    DocumentReference docRef = motor.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> deleteMotor(String docID) async {
    DocumentReference motorData = motor.doc(docID);
    DocumentSnapshot motorSnapshot = await getMotorById(docID);
    await FirebaseStorage.instance
        .refFromURL(motorSnapshot.get('Image'))
        .delete();
    return motorData.delete();
  }

  Future<void> updateMotor(String docID, String namaMotor, int kapasitasMesin,
      int harga, String merk, String imageUrl) async {
    DocumentReference docRef = motor.doc(docID);

    await docRef.update({
      'Image': imageUrl,
      'harga': harga,
      'isOrdered': false,
      'kapasitas_mesin': kapasitasMesin,
      'merk': merk,
      'namaMotor': namaMotor,
    });
  }

  Future<void> salesUpdate(String docID, int totalPenjualan) async {
    DocumentReference docRef = motor.doc(docID);

    await docRef.update({'totalPenjualan': totalPenjualan});
  }

  Future<void> statusUpdate(String docID) async {
    DocumentReference docRef = motor.doc(docID);

    await docRef.update({'isOrdered': false});
  }
}

class Motors {
  final bool isOrdered;

  Motors({required this.isOrdered});

  Map<String, dynamic> toMap() {
    return {
      'isOrdered':
          isOrdered, // Assuming 'status' is the only field you want to update
    };
  }
}
