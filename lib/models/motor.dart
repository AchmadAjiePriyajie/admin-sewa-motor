import 'package:cloud_firestore/cloud_firestore.dart';

class Motor {
  final String namaMotor;
  final int harga;
  final String imageUrl;
  final String merk;
  final int kapasitasMesin;
  final bool isOrdered;
  final Timestamp? timestamp;
  final int? totalPenjualan;

  Motor({
    required this.namaMotor,
    required this.harga,
    required this.merk,
    required this.kapasitasMesin,
    required this.imageUrl,
    required this.isOrdered,
    this.timestamp,
    this.totalPenjualan
  });

  factory Motor.fromJson(Map<String, dynamic> json) => Motor(
        namaMotor: json['namaMotor'] as String,
        harga: json['harga'] as int,
        merk: json['merk'] as String,
        kapasitasMesin: json['kapasitas_mesin'] as int,
        imageUrl: json['Image'] as String,
        isOrdered: json['isOrdered'] as bool,
        timestamp: json['timestamp'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'namaMotor': namaMotor,
        'harga': harga,
        'merk': merk,
        'kapasitas_mesin': kapasitasMesin,
        'Image': imageUrl,
        'isOrdered': isOrdered,
        'timestamp': timestamp,
        'totalPenjualan' : 0
      };
}
