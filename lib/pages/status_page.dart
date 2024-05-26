import 'package:admin_sewa_motor/Services/transaction_services.dart';
import 'package:admin_sewa_motor/pages/detail_transaksi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StatusPage extends StatefulWidget {
  final String status;
  StatusPage({super.key, required this.status});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  TransactionServices transactionServices = TransactionServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        title: Text(
          'Status',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              transactionServices.getTransactionStreamByStatus(widget.status),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> transactionList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: transactionList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = transactionList[index];
                  // get note from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  String docId = document.id;
                  String id = data['transactionId'];
                  double price = data['total_price'];
                  String status = data['status'];
                  DocumentReference motorData = data['motorId'];

                  return FutureBuilder(
                      future: motorData.get(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        
                        if (snapshot.hasData){
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailTransaksiPage(docId: docId),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(
                                left: 10, right: 10,top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Image.network(
                                  snapshot.data?['Image'] ,
                                  height: 90,
                                  width: 100,
                                ),
                                Container(
                                  height: 90,
                                  width: 255,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data?['namaMotor'] ,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ID : ' + id,
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Total : ' + NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp ').format(price),
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: status == 'Completed'
                                                ?Colors.green
                                                :Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Text(
                                                status,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                        }
                        return Text('');
                      }

                      );
                },
              );
            } else {
              return Text(
                'Belum ada motor',
              );
            }
          }),
    );
  }
}
