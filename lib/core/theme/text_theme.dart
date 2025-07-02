part of 'theme.dart';


/// [_textTheme] acts as a getter to [TextTheme], based on some argument.
/// For example, with specific font.
TextTheme _textTheme({required String fontFamily, required Color bodyColor}) {
  const fontFeatures = [FontFeature.enable('lnum')];

  return ThemeData.light()
      .textTheme
      .copyWith(
    displayLarge: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 36,
      fontWeight: FontWeight.bold,
      height: 1.4,
    ),
    displayMedium: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.4,
    ),
    displaySmall: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    headlineLarge: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1.4,
    ),
    headlineMedium: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 1.4,
    ),
    headlineSmall: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    titleLarge: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    titleMedium: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    titleSmall: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    labelLarge: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    labelMedium: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    labelSmall: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1,
      letterSpacing: 0.1,
    ),
    bodyLarge: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 2,
    ),
    bodyMedium: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    bodySmall: const TextStyle(
      fontFeatures: fontFeatures,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
  )
      .apply(
    fontFamily: fontFamily,
    bodyColor: bodyColor,
    displayColor: AppColors.textPrimary,
  );
}
