import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider {
  ///Using google font, your can change the font or use your custom font
  static String? fontFamily = GoogleFonts.poppins().fontFamily;

  ///Using flex_color_scheme package for simple color scheme, you can use your custom light and dark theme here
  static ThemeData lightTheme = FlexThemeData.light(
      scheme: FlexScheme.aquaBlue, fontFamily: fontFamily, useMaterial3: true);
  static ThemeData darkTheme = FlexThemeData.dark(
      scheme: FlexScheme.aquaBlue, fontFamily: fontFamily, useMaterial3: true);
}
