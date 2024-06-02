import 'package:admin_sewa_motor/Services/motor_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MotorDetailPage extends StatefulWidget {
  final String docID;

  const MotorDetailPage({super.key, required this.docID});

  @override
  State<MotorDetailPage> createState() => _MotorDetailPageState();
}

class _MotorDetailPageState extends State<MotorDetailPage> {
  Future<DocumentSnapshot?>? _motorData; // Use a Future to hold the data
  MotorService motorService = MotorService();

  @override
  void initState() {
    super.initState();
    _motorData =
        motorService.getMotorById(widget.docID); // Call getMotorById on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motor Details'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot?>(
          future: _motorData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Handle errors
            }

            if (!snapshot.hasData) {
              return const CircularProgressIndicator(); // Show loading indicator
            }

            DocumentSnapshot motorDoc = snapshot.data!;
            if (!motorDoc.exists) {
              return const Text('Motor not found'); // Handle non-existent motor
            }

            // Extract motor data
            String namaMotor = motorDoc['namaMotor'];
            int kapasitasMesin = motorDoc['kapasitas_mesin'];
            int harga = motorDoc['harga'];
            String merk = motorDoc['merk'];
            String imageUrl = motorDoc['Image'];
            
            // Display motor details
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 300,
                      ) // Display image
                    : const Text('No image available'),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.lightBlue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Text(
                          namaMotor,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Text(
                          'Merk',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          merk,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Kapasitas Mesin',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          '${kapasitasMesin.toString()} cc',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Harga',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          NumberFormat.currency(locale: 'id' , decimalDigits: 0 , symbol: 'Rp ').format(harga),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

