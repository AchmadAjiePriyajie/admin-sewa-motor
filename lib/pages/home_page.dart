import 'package:admin_sewa_motor/Services/transaction_services.dart';
import 'package:admin_sewa_motor/Services/user_services.dart';
import 'package:admin_sewa_motor/components/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TransactionServices transactionServices = TransactionServices();
  UserServices userServices = UserServices();

  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transactions');

  Future<AggregateQuerySnapshot> getTotal() async {
    final count = await transaction.where('status' , isNotEqualTo: 'Pending').aggregate(sum("total_price")).get();
    return count;
  }

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
          'Home Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Pengguna',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: userServices.getUserStreamTotal(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final transactionList = snapshot.data!.docs;
                                  final total = transactionList.length;
                                  return Text(
                                    total.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  return const Text('0');
                                }
                              },
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 180,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Pesanan',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Icon(
                            Icons.receipt_long_outlined,
                            size: 50,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: transactionServices
                                  .getTransactionStreamTotal(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final transactionList = snapshot.data!.docs;
                                  final total = transactionList.length;
                                  return Text(
                                    total.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  return const Text('0');
                                }
                              },
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 380,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Penjualan',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Icon(
                            Icons.monetization_on_rounded,
                            size: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FutureBuilder(
                            future: getTotal(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int? total = snapshot.data!
                                    .getSum('total_price')!
                                    .toInt();
                                int _total = total;

                                return Text(
                                  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                      .format(_total),
                                  style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
