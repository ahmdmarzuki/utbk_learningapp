import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerText extends StatelessWidget {
  final String text;
  final Color color;
  const BannerText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w600, color: color),
    );
  }
}
