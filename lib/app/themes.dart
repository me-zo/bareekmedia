import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkTheme = themeData(darkColorScheme, _darkFocusColor);

  static Color cardColor(BuildContext context) => Color.alphaBlend(
        Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.1),
        Theme.of(context).colorScheme.background,
      );
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 5,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        foregroundColor: colorScheme.tertiary,
      ),
      iconTheme: IconThemeData(color: colorScheme.onBackground),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: colorScheme.onBackground,
        labelColor: colorScheme.tertiary,
      ),
      canvasColor: colorScheme.background,
      cardColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.6),
          _darkFillColor,
        ),
      ),
    );
  }

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF0057AF),
    secondary: Color(0xFF1499FF),
    tertiary: Colors.white,
    onTertiary: Colors.black,
    background: Color(0xFF424242),
    onBackground: Color(0xFF8C8C8C),
    surface: Color(0xFF1E1E1E),
    onInverseSurface: Color(0xFF00489B),
    shadow: _darkFillColor,
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF0057AF),
    secondary: Color(0xFF1499FF),
    tertiary: Colors.white,
    onTertiary: Colors.black,
    background: Color(0xFFD2D2D2),
    onBackground: Color(0xFF949494),
    surface: Color(0xFF5B5B5B),
    onInverseSurface: Color(0xFF8D00FF),
    shadow: _lightFillColor,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: _lightFillColor,
    onSurface: _lightFillColor,
    brightness: Brightness.light,
  );
}
