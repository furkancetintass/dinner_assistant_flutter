import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xfff6f8fa),
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Color(0xff2D2D2F),
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600)),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 12),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade800, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade800, width: 2),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.8))),
    ));
