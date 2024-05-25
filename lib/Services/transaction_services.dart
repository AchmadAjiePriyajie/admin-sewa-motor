import 'package:admin_sewa_motor/Services/motor_service.dart';
import 'package:admin_sewa_motor/models/transaksi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionServices {
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transactions');

  Stream<QuerySnapshot> getTransactionStream() {
    final transactionStream =
        transaction.orderBy('orderedAt', descending: true).snapshots();
    return transactionStream;
  }

  MotorService motorService = MotorService();

  Stream<QuerySnapshot> getTransactionStreamByStatus(String status) {
    final transactionStream =
        transaction.where("status", isEqualTo: status).snapshots();
    return transactionStream;
  }

  Future<DocumentSnapshot> getTransactionById(String docID) async {
    DocumentReference docRef = transaction.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> StatusUpdate(String docID, String status) async {
    DocumentReference docRef = transaction.doc(docID);

    // Update specific field (recommended)
    await docRef
        .update({'status': status}); // Directly update the 'status' field

    // Update with custom class
    final transactionData = Transaksi(status: status);
    await docRef.update(
        transactionData.toMap()); // Assuming Transaksi has a 'toMap()' method
  }
}
