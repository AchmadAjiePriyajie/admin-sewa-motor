class Transaksi {
  final String status;

  Transaksi({required this.status});

  Map<String, dynamic> toMap() {
    return {
      'status': status, // Assuming 'status' is the only field you want to update
    };
  }
}