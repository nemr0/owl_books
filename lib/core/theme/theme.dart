
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

part 'text_theme.dart';


class AppTheme {
  static TextTheme textTheme = _textTheme(
    fontFamily: GoogleFonts.robotoFlex().fontFamily!,
    bodyColor: AppColors.textPrimary,
  );
  ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.light,
    textTheme: textTheme,
    // fontFamily: "Gilroy",
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent
    ),
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.light,
    ),
  );
  static final AppTheme _instance = AppTheme._internal();

  static AppTheme get instance => _instance;

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
