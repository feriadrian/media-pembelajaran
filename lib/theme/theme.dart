import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(),
    primaryColor: Colors.blue[600],
    appBarTheme: AppBarTheme(
        iconTheme: iconThemeData(),
        backgroundColor: Colors.white,
        titleTextStyle:
            GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
  );
}

IconThemeData iconThemeData() {
  return const IconThemeData(
    color: Colors.blue,
  );
}
