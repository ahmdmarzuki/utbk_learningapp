import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CardImage extends StatelessWidget {
  final String image;
  double? height;
  double? width;
  CardImage(
      {super.key, required this.image, this.height = 52, this.width = 52});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: HexColor.imageBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Image.network(
        image,
        errorBuilder: (context, error, stackTrace) {
          return Center(
              child: Text(
            "No Img",
            style: GoogleFonts.poppins(fontSize: 8),
          ));
        },
      ),
    );
  }
}
