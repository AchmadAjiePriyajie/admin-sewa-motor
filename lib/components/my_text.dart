import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  

  const MyText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
    ));
  }
}
