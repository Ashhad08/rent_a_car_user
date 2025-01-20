import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemes {
  final AppColors _appColors;

  AppThemes({required AppColors appColors}) : _appColors = appColors;

  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          onPrimary: Colors.white,
          // surface: Color(0xff384322),
          // onSecondary: Colors.black,
          seedColor: _appColors.kPrimaryColor,
          // outline: _appColors.kBorderColor,
          secondary: _appColors.kSecondaryColor,
        ),
        scaffoldBackgroundColor: Color(0xff111214),
        textTheme: GoogleFonts.poppinsTextTheme(),
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Color(0xff111214),
          surfaceTintColor: Color(0xff111214)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: _appColors.kPrimaryColor,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero,
            textStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _appColors.kPrimaryColor,
            textStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _appColors.kPrimaryColor),
          ),
        ),
      );
}
