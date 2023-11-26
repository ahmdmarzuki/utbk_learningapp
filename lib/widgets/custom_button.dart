import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
   
  final String icon;
  final String text;
  final Color bgColor;
  final Color textColor;
  final void Function()? onPressed;
  const CustomButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.bgColor,
      required this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(bgColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(icon),
            SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
