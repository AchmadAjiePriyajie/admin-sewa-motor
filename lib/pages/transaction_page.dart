import 'package:admin_sewa_motor/Services/transaction_services.dart';
import 'package:admin_sewa_motor/components/my_drawer.dart';
import 'package:admin_sewa_motor/pages/detail_transaksi.dart';
import 'package:admin_sewa_motor/pages/status_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TransactionServices transactionServices = TransactionServices();
  String? status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            color: Colors.white,
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: Text(
          'Transaction',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Text(
                  'Status Transaction',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatusPage(status: 'Pending'),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 90,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  height: 22,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: transactionServices
                                        .getTransactionStreamByStatus(
                                            'Pending'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final transactionList =
                                            snapshot.data!.docs;
                                        final total = transactionList.length;
                                        return Text(
                                          total.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            "Error: ${snapshot.error}");
                                      } else {
                                        return const Text('0');
                                      }
                                    },
                                  )),
                            ),
                            Text(
                              'Pending',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatusPage(status: 'Paid'),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 90,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  height: 22,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: transactionServices
                                        .getTransactionStreamByStatus('Paid'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final transactionList =
                                            snapshot.data!.docs;
                                        final total = transactionList.length;
                                        return Text(
                                          total.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            "Error: ${snapshot.error}");
                                      } else {
                                        return const Text('0');
                                      }
                                    },
                                  )),
                            ),
                            Text(
                              'Paid',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatusPage(status: 'Ongoing'),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 90,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  height: 22,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: transactionServices
                                        .getTransactionStreamByStatus(
                                            'Ongoing'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final transactionList =
                                            snapshot.data!.docs;
                                        final total = transactionList.length;
                                        return Text(
                                          total.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            "Error: ${snapshot.error}");
                                      } else {
                                        return const Text('0');
                                      }
                                    },
                                  )),
                            ),
                            Text(
                              'Ongoing',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatusPage(status: 'Completed'),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 90,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  height: 22,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: transactionServices
                                        .getTransactionStreamByStatus(
                                            'Completed'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final transactionList =
                                            snapshot.data!.docs;
                                        final total = transactionList.length;
                                        return Text(
                                          total.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            "Error: ${snapshot.error}");
                                      } else {
                                        return const Text('0');
                                      }
                                    },
                                  )),
                            ),
                            Text(
                              'Completed',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Recent Transaction',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.history),
                  ],
                ),
                Container(
                  height: 550,
                  child: StreamBuilder<QuerySnapshot>(
          stream:
              transactionServices.getTransactionStream(),
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
                                left: 10, right: 10, bottom: 10),
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
                                  width: 240,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data?['namaMotor'] ?? '-',
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
                                            'Total : Rp.' + price.toString(),
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
                                                color: Colors.red,
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
                        return Text('Transaksi tidak ditemukan');
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
