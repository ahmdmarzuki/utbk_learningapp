import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarHeading extends StatelessWidget {
  final String text;
  final Color color;
  const AppbarHeading({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 12, fontWeight: FontWeight.w600, color: color),
    );
  }
}
