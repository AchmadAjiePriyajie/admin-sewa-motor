import 'package:admin_sewa_motor/firebase_options.dart';
import 'package:admin_sewa_motor/pages/form_motor_page.dart';
import 'package:admin_sewa_motor/pages/home_page.dart';
import 'package:admin_sewa_motor/pages/motor_page.dart';
import 'package:admin_sewa_motor/pages/transaction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/home_page': (context) => HomePage(),
        '/motor_page': (context) => MotorPage(),
        '/add_motor_page': (context) => FormMotorPage(),
        '/transaction_page': (context) => TransactionPage(),
      },
    );
  }
}
