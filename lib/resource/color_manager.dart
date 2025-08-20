import 'package:flutter/material.dart';

class ColorManager {
  static final Color primary = HexColor.fromHex("#00ADC1");
  static final Color primaryMedium = HexColor.fromHex("#B0E6EC");
  static final Color primaryLight = HexColor.fromHex("#D9F3F6");

  static final Color secondary = HexColor.fromHex("#19D0C7");
  static final Color secondaryMedium = HexColor.fromHex("#B8F0EE");
  static final Color secondaryLight = HexColor.fromHex("#DDF8F7");

  static final Color stateDanger = HexColor.fromHex("#CD201F");
  static final Color stateSuccess = HexColor.fromHex("#0EB78C");
  static final Color stateInfo = HexColor.fromHex("#FFC107");

  static final Color grey = HexColor.fromHex("#777777");
  static final Color greyDark = HexColor.fromHex("#363636");
  static final Color greyMedium = HexColor.fromHex("#474747");
  static final Color greyLight = HexColor.fromHex("#D5D5D5");

  static final Color white = HexColor.fromHex("#FFFFFF");
  static final Color black = HexColor.fromHex("#000000");

  static final pinkDark=HexColor.fromHex("FD3A3A");
  static final pinkLight=HexColor.fromHex("FFD7D7");

  static final irisDark=HexColor.fromHex("5D5FEF");
  // static final irisLight=HexColor.fromHex("C9C5F3");
  static final irisLight=HexColor.fromHex("D2D3FF");

  static final blue=HexColor.fromHex("008FCB");
  static final green=HexColor.fromHex("77BF03");
  static final red=HexColor.fromHex("FF0000");
  static final orange=HexColor.fromHex("FF4D00");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) hexColorString = "FF$hexColorString";
    return Color(int.parse(hexColorString, radix: 16));
  }
}
