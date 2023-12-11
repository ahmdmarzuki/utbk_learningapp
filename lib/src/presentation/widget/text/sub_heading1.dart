import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SubHeading extends StatelessWidget {
  final String text;
  final double fontSize;
  Color? color;
  SubHeading({
    Key? key,
    this.color = const Color.fromARGB(255, 66, 66, 66),
    required this.text,
    this.fontSize = 12,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: fontSize, color: color),
    );
  }
}
