import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SubHeading1 extends StatelessWidget {
  final String text;
  Color? color;
  SubHeading1({
    Key? key,
    this.color = const Color.fromARGB(255, 66, 66, 66),
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 12, color: color),
    );
  }
}
