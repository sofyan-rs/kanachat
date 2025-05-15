import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanachat/core/themes/app_colors.dart';

TextTheme getTextTheme() {
  return GoogleFonts.dmMonoTextTheme(
    TextTheme().copyWith(
      //
    ),
  );
}

class AppThemes {
  ThemeData get lightTheme => ThemeData(
    textTheme: getTextTheme(),
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.lightSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primary),
      toolbarHeight: 70,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.lightSurface,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    textTheme: getTextTheme(),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.darkSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primary),
      toolbarHeight: 70,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.darkSurface,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
  );
}
