import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as googlefont;

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: googlefont.GoogleFonts.poppinsTextTheme(),
    primaryColor: Colors.blue[600],
    appBarTheme: AppBarTheme(
        iconTheme: iconThemeData(),
        backgroundColor: Colors.white,
        titleTextStyle: googlefont.GoogleFonts.poppins(
            fontSize: 18, fontWeight: FontWeight.bold)),
  );
}

IconThemeData iconThemeData() {
  return const IconThemeData(
    color: Colors.blue,
  );
}
