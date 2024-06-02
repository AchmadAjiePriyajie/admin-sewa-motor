import 'package:admin_sewa_motor/Services/motor_service.dart';
import 'package:admin_sewa_motor/Services/transaction_services.dart';
import 'package:admin_sewa_motor/Services/user_services.dart';
import 'package:admin_sewa_motor/components/my_button.dart';
import 'package:admin_sewa_motor/components/my_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTransaksiPage extends StatefulWidget {
  final docId;
  const DetailTransaksiPage({super.key, required this.docId});

  @override
  State<DetailTransaksiPage> createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
  TransactionServices transactionServices = TransactionServices();
  String? status;
  int? durasiSewa;
  String? metodePembayaran;

  Widget Transaction() {
    return Container();
  }

  void updateStatus(String _status, int totalPenjualan, String motorId) {
    showDialog(
      context: context,
      builder: (context) {
        if (status == 'Paid') {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah anda yakin ingin konfirmasi pengambilan'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  TransactionServices().StatusUpdate(widget.docId!, _status);
                  TransactionServices().countdownUpdate(widget.docId, durasiSewa!);
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, '/transaction_page');
                },
                child: Text(
                  'Konfirmasi',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        } else if (status == 'Ongoing') {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah anda yakin ingin konfirmasi pengembalian'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  TransactionServices().StatusUpdate(widget.docId!, _status);
                  MotorService().salesUpdate(motorId, totalPenjualan);
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, '/transaction_page');
                },
                child: Text(
                  'Konfirmasi',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        } else if (status == 'Pending') {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah anda yakin ingin konfirmasi pembayaran'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  TransactionServices().StatusUpdate(widget.docId!, _status);

                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, '/transaction_page');
                },
                child: Text(
                  'Konfirmasi',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        }
        return Text('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        title: Text(
          'Detail Transaksi',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot?>(
            future: transactionServices.getTransactionById(widget.docId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(); // Show loading indicator
              }

              DocumentSnapshot transactionDoc = snapshot.data!;
              if (!transactionDoc.exists) {
                return const Text(
                  'Transaction not found',
                ); // Handle non-existent motor
              }
              String transactionId = transactionDoc['transactionId'];
              durasiSewa = transactionDoc['duration'];
              double total = transactionDoc['total_price'];
              metodePembayaran = transactionDoc['payment_method'];
              status = transactionDoc['status'];
              Timestamp order = transactionDoc['orderedAt'];
              DateTime _order = order.toDate();
              DocumentReference motorData = transactionDoc['motorId'];
              DocumentReference userData = transactionDoc['userId'];

              return FutureBuilder(
                future: motorData.get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot motorDoc = snapshot.data!;
                    String namaMotor = motorDoc['namaMotor'];
                    int harga = motorDoc['harga'];
                    int totalPenjualan = motorDoc['totalPenjualan'];
                    String motorId = motorDoc.id;

                    return FutureBuilder(
                      future: userData.get(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          DocumentSnapshot userDoc = snapshot.data!;
                          String namaUser = userDoc['username'];
                          String email = userDoc['email'];
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        MyText(
                                          text: 'Rincian Pesanan',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Icon(Icons.access_time),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Nama Costumer',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: namaUser,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Order At',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: DateFormat('dd MMMM yyyy HH:mm').format(_order),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Kode Pemesanan',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: transactionId,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Nama Motor',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: namaMotor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Durasi Sewa',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                          text: '${durasiSewa.toString()} Jam',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Harga Sewa',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp ',
                                                    decimalDigits: 0)
                                                .format(harga),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                          text: 'Total',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp ',
                                                    decimalDigits: 0)
                                                .format(total),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Metode Pembayaran',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: metodePembayaran.toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: 'Status Pembayaran',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                            text: status!,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    AnimatedSwitcher(
                                      duration: Duration(
                                          milliseconds:
                                              300), // Adjust animation duration as needed
                                      // Customize the transition if desired
                                      child: Column(
                                        children: [
                                          status == 'Paid'
                                              ? MyButton(
                                                  text:
                                                      'Konfirmasi Pengambilan',
                                                  fontSize: 14,
                                                  onTap: () {
                                                    updateStatus('Ongoing', 0, motorId);
                                                  },
                                                )
                                              : status == 'Ongoing'
                                                  ? MyButton(
                                                      text:
                                                          'Konfirmasi Pengambilan',
                                                      fontSize: 14,
                                                      onTap: () {
                                                        int _totalPenjualan = totalPenjualan + 1;
                                                        updateStatus(
                                                            'Completed', _totalPenjualan, motorId);
                                                        UserServices()
                                                            .transactionIdUpdate(
                                                                email);
                                                        MotorService()
                                                            .statusUpdate(
                                                                motorDoc.id);
                                                      },
                                                    )
                                                  : status == 'Pending' &&
                                                          metodePembayaran ==
                                                              'Cash'
                                                      ? MyButton(
                                                          text:
                                                              'Konfirmasi Pembayaran',
                                                          fontSize: 14,
                                                          onTap: () {
                                                            updateStatus(
                                                                'Paid', 0, motorId);
                                                          },
                                                        )
                                                      : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
