class Users {
  final String transactionId;

  Users({required this.transactionId});

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId, // Assuming 'status' is the only field you want to update
    };
  }
}