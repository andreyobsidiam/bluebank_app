import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0058bc),
      surfaceTint: Color(0xff005bc1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0070eb),
      onPrimaryContainer: Color(0xfffefcff),
      secondary: Color(0xff0f2780),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2c4097),
      onSecondaryContainer: Color(0xffa4b2ff),
      tertiary: Color(0xff7a5901),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd175),
      onTertiaryContainer: Color(0xff795800),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff181c23),
      onSurfaceVariant: Color(0xff414755),
      outline: Color(0xff717786),
      outlineVariant: Color(0xffc1c6d7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3039),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004493),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff001257),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff2b3f96),
      tertiaryFixed: Color(0xffffdea2),
      onTertiaryFixed: Color(0xff261900),
      tertiaryFixedDim: Color(0xffedc066),
      onTertiaryFixedVariant: Color(0xff5c4200),
      surfaceDim: Color(0xffd8d9e5),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f3fe),
      surfaceContainer: Color(0xffecedf9),
      surfaceContainerHigh: Color(0xffe6e8f3),
      surfaceContainerHighest: Color(0xffe0e2ed),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003474),
      surfaceTint: Color(0xff005bc1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0069dd),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0f2780),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2c4097),
      onSecondaryContainer: Color(0xffdde0ff),
      tertiary: Color(0xff483300),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8a6714),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff0e1119),
      onSurfaceVariant: Color(0xff303643),
      outline: Color(0xff4d5261),
      outlineVariant: Color(0xff676d7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3039),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xff0069dd),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0051ae),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5467bf),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3a4ea5),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8a6714),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff6e5000),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c6d1),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f3fe),
      surfaceContainer: Color(0xffe6e8f3),
      surfaceContainerHigh: Color(0xffdadce7),
      surfaceContainerHighest: Color(0xffcfd1dc),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002a61),
      surfaceTint: Color(0xff005bc1),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004698),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff05217b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2c4097),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3b2900),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5f4500),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff262c39),
      outlineVariant: Color(0xff434957),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3039),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xff004698),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00306d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2d4198),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff112981),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5f4500),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff432f00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6b8c3),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef0fc),
      surfaceContainer: Color(0xffe0e2ed),
      surfaceContainerHigh: Color(0xffd2d4df),
      surfaceContainerHighest: Color(0xffc4c6d1),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff002e69),
      primaryContainer: Color(0xff4b8eff),
      onPrimaryContainer: Color(0xff001435),
      secondary: Color(0xffb9c3ff),
      onSecondary: Color(0xff0d267f),
      secondaryContainer: Color(0xff2c4097),
      onSecondaryContainer: Color(0xffa4b2ff),
      tertiary: Color(0xfffff2e0),
      onTertiary: Color(0xff402d00),
      tertiaryContainer: Color(0xffffd175),
      onTertiaryContainer: Color(0xff795800),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10131b),
      onSurface: Color(0xffe0e2ed),
      onSurfaceVariant: Color(0xffc1c6d7),
      outline: Color(0xff8b90a0),
      outlineVariant: Color(0xff414755),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ed),
      inversePrimary: Color(0xff005bc1),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004493),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff001257),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff2b3f96),
      tertiaryFixed: Color(0xffffdea2),
      onTertiaryFixed: Color(0xff261900),
      tertiaryFixedDim: Color(0xffedc066),
      onTertiaryFixedVariant: Color(0xff5c4200),
      surfaceDim: Color(0xff10131b),
      surfaceBright: Color(0xff363942),
      surfaceContainerLowest: Color(0xff0b0e16),
      surfaceContainerLow: Color(0xff181c23),
      surfaceContainer: Color(0xff1c2028),
      surfaceContainerHigh: Color(0xff272a32),
      surfaceContainerHighest: Color(0xff31353d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcfdcff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff002454),
      primaryContainer: Color(0xff4b8eff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd5daff),
      onSecondary: Color(0xff001a6f),
      secondaryContainer: Color(0xff788be6),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff2e0),
      onTertiary: Color(0xff402d00),
      tertiaryContainer: Color(0xffffd175),
      onTertiaryContainer: Color(0xff553d00),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff10131b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd7dced),
      outline: Color(0xffacb2c2),
      outlineVariant: Color(0xff8b90a0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ed),
      inversePrimary: Color(0xff004596),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff00102d),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff003474),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff000a3d),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff162d85),
      tertiaryFixed: Color(0xffffdea2),
      onTertiaryFixed: Color(0xff190f00),
      tertiaryFixedDim: Color(0xffedc066),
      onTertiaryFixedVariant: Color(0xff483300),
      surfaceDim: Color(0xff10131b),
      surfaceBright: Color(0xff41444d),
      surfaceContainerLowest: Color(0xff05070e),
      surfaceContainerLow: Color(0xff1a1e25),
      surfaceContainer: Color(0xff252830),
      surfaceContainerHigh: Color(0xff2f323b),
      surfaceContainerHighest: Color(0xff3a3e46),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecefff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa7c3ff),
      onPrimaryContainer: Color(0xff000a22),
      secondary: Color(0xffefefff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb4bfff),
      onSecondaryContainer: Color(0xff00062f),
      tertiary: Color(0xfffff2e0),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffd175),
      onTertiaryContainer: Color(0xff2e1f00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff10131b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecefff),
      outlineVariant: Color(0xffbdc2d3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ed),
      inversePrimary: Color(0xff004596),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff00102d),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff000a3d),
      tertiaryFixed: Color(0xffffdea2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffedc066),
      onTertiaryFixedVariant: Color(0xff190f00),
      surfaceDim: Color(0xff10131b),
      surfaceBright: Color(0xff4d5059),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c2028),
      surfaceContainer: Color(0xff2d3039),
      surfaceContainerHigh: Color(0xff383b44),
      surfaceContainerHighest: Color(0xff434750),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
