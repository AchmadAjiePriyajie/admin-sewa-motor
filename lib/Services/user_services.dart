import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_sewa_motor/models/users.dart';

class UserServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> transactionIdUpdate(String docID) async {
    DocumentReference docRef = users.doc(docID);

    // Update specific field (recommended)
    await docRef
        .update({'transactionId': ''}); // Directly update the 'transactionId' field

    // Update with custom class
    final transactionData = Users(transactionId: '');
    await docRef.update(
        transactionData.toMap()); // Assuming Transaksi has a 'toMap()' method
  }
}
