import 'dart:async';

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

  Stream<QuerySnapshot> getTransactionStreamTotal() {
    final transactionStream = transaction.snapshots();
    return transactionStream;
  }

  Future<DocumentSnapshot> getTransactionById(String docID) async {
    DocumentReference docRef = transaction.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> StatusUpdate(String docID, String status) async {
    DocumentReference docRef = transaction.doc(docID);

    await docRef.update({'status': status});

    final transactionData = Transaksi(status: status);
    await docRef.update(transactionData.toMap());
  }

  Future<void> countdownUpdate(String docID, int duration) async {
    DocumentReference docRef = transaction.doc(docID);
    Timestamp orderedAt = Timestamp.now();
    DateTime orderedAtDateTime = orderedAt.toDate();
    DateTime endDurationDateTime = orderedAtDateTime.add(Duration(hours: duration ));
    Timestamp endDuration = Timestamp.fromDate(endDurationDateTime);
    await docRef.update({'endDuration' : endDuration });
  }

  Future<AggregateQuerySnapshot> getTotal() async {
    final count = await transaction.aggregate(sum("total_price")).get();
    return count;
  }
}
