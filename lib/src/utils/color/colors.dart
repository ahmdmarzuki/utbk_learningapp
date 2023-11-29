import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static Color grey = HexColor("4e4e4e");
  static Color black = HexColor("000000");
  static Color blue_ = HexColor("3A7FD5");
  static Color white = HexColor("FFFFFF");
  static Color whiteBackground = HexColor("F3F7F8");
  static Color imageBackground = HexColor("f5f5f5");
}
