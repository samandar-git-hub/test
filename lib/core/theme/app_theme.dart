import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export '../extensions/context_extensions.dart';
export 'app_styles.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {

  final Color transparent;
  final Color white;
  final Color black;

  final Color background;
  final Color sidebar;
  final Color surface;
  final Color surfaceLight;
  final Color borderDark;
  final Color borderMedium;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color violet;
  final Color violetDark;
  final Color blue;
  final Color emerald;
  final Color red;
  final Color amber;
  final Color hover;

  const AppColors({
    required this.transparent,
    required this.white,
    required this.black,

    required this.background,
    required this.sidebar,
    required this.surface,
    required this.surfaceLight,
    required this.borderDark,
    required this.borderMedium,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.violet,
    required this.violetDark,
    required this.blue,
    required this.emerald,
    required this.red,
    required this.amber,
    required this.hover,
  });

  @override
  AppColors copyWith({
    Color? transparent,
    Color? white,
    Color? black,

    Color? background,
    Color? sidebar,
    Color? surface,
    Color? surfaceLight,
    Color? borderDark,
    Color? borderMedium,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? violet,
    Color? violetDark,
    Color? blue,
    Color? emerald,
    Color? red,
    Color? amber,
    Color? hover,
  }) {
    return AppColors(
      transparent: transparent ?? this.transparent,
      white: white ?? this.white,
      black: black ?? this.black,

      background: background ?? this.background,
      sidebar: sidebar ?? this.sidebar,
      surface: surface ?? this.surface,
      surfaceLight: surfaceLight ?? this.surfaceLight,
      borderDark: borderDark ?? this.borderDark,
      borderMedium: borderMedium ?? this.borderMedium,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      violet: violet ?? this.violet,
      violetDark: violetDark ?? this.violetDark,
      blue: blue ?? this.blue,
      emerald: emerald ?? this.emerald,
      red: red ?? this.red,
      amber: amber ?? this.amber,
      hover: hover ?? this.hover,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      transparent: Color.lerp(transparent, other.transparent, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,

      background: Color.lerp(background, other.background, t)!,
      sidebar: Color.lerp(sidebar, other.sidebar, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceLight: Color.lerp(surfaceLight, other.surfaceLight, t)!,
      borderDark: Color.lerp(borderDark, other.borderDark, t)!,
      borderMedium: Color.lerp(borderMedium, other.borderMedium, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      violet: Color.lerp(violet, other.violet, t)!,
      violetDark: Color.lerp(violetDark, other.violetDark, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      emerald: Color.lerp(emerald, other.emerald, t)!,
      red: Color.lerp(red, other.red, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      hover: Color.lerp(hover, other.hover, t)!,
    );
  }

  static const light = AppColors(
    transparent: Colors.transparent,
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),

    background: Color(0xFFF8FAFC),
    sidebar: Color(0xFFFFFFFF),
    surface: Color(0xFFF1F5F9),
    surfaceLight: Color(0xFFE2E8F0),
    borderDark: Color(0xFFE2E8F0),
    borderMedium: Color(0xFFCBD5E1),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF94A3B8),
    violet: Color(0xFF7C3AED),
    violetDark: Color(0xFF6D28D9),
    blue: Color(0xFF2563EB),
    emerald: Color(0xFF059669),
    red: Color(0xFFDC2626),
    amber: Color(0xFFD97706),
    hover: Color(0x0F000000),
  );

  static const dark = AppColors(
    transparent: Colors.transparent,
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    
    background: Color(0xFF0D0F16),
    sidebar: Color(0xFF131722),
    surface: Color(0xFF1B2030),
    surfaceLight: Color(0xFF262C3F),
    borderDark: Color(0xFF222838),
    borderMedium: Color(0xFF323B52),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    violet: Color(0xFFC084FC),
    violetDark: Color(0xFFA855F7),
    blue: Color(0xFF60A5FA),
    emerald: Color(0xFF34D399),
    red: Color(0xFFF87171),
    amber: Color(0xFFFBBF24),
    hover: Color(0x0FFFFFFF),
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.light.background,
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      extensions: const <ThemeExtension<dynamic>>[AppColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.dark.background,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      extensions: const <ThemeExtension<dynamic>>[AppColors.dark],
    );
  }
}
