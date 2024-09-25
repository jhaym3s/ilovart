import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';


class AppTheme {
  /// Constructs an [AppTheme].
  AppTheme() {
    lightTheme = ThemeData(
      useMaterial3: true,
      //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      fontFamily: kFontFamily,
      brightness: Brightness.light,
      textTheme: lightModeAppTextTheme(),
      primaryColorLight: kPrimaryColor,
      //buttonColor: kPrimaryColor,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: lightScaffoldBackgroundColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xfff5f5f5),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: kPrimaryColor
      ),
      //colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface),
      // buttonTheme: const ButtonThemeData(
      //   textTheme: ButtonTextTheme.accent,
      //   minWidth: 88,
      //   height: 48,
      //   padding: EdgeInsets.only(left: kPaddingM, right: kPaddingM),
      //   shape: RoundedRectangleBorder(
      //     side: BorderSide(
      //       color: Color(0xff000000),
      //       width: 0,
      //       style: BorderStyle.none,
      //     ),
      //     borderRadius: BorderRadius.all(Radius.circular(kFormFieldsRadius)),
      //   ),
      //   buttonColor: kPrimaryColor,
      //   disabledColor: Color(0x61000000),
      //   highlightColor: Color(0x29000000),
      //   splashColor: Color(0x1f000000),
      //   focusColor: Color(0x1f000000),
      //   hoverColor: Color(0x0a000000),
      // ),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          color: Color(0xfff9fafc),
          iconTheme: IconThemeData(color: kBlack)),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xFFF0F0F0),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        contentPadding: EdgeInsets.only(
          top: 16,
          bottom: 16,
          left: 16,
          right: 16,
        ),
      ), 
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary:kPrimaryColor,
          onPrimary: kWhite,
          secondary: kPrimaryColor,
          onSecondary: kWhite,
          error: kError,
          onError: kWhite,
          background: kWhite,
          onBackground:  kTextColorsLight,
          surface: kWhite,
          onSurface:  kTextColorsLight,
          
          ).copyWith(secondary: kPrimaryColor),
    );
    darkTheme = ThemeData(
      fontFamily: kFontFamily,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff20242b),
      cardColor: const Color(0xff2b2f38),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: kPrimaryColor,
        disabledColor: kGrey,
      ),
      //colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface),
      // buttonTheme: const ButtonThemeData(
      //   textTheme: ButtonTextTheme.accent,
      //   minWidth: 88,
      //   height: 48,
      //   padding: EdgeInsets.symmetric(horizontal: kPaddingM),
      //   shape: RoundedRectangleBorder(
      //     side: BorderSide(
      //       color: Color(0xff000000),
      //       width: 0,
      //       style: BorderStyle.none,
      //     ),
      //     borderRadius: BorderRadius.all(Radius.circular(kFormFieldsRadius)),
      //   ),
      //   buttonColor: kPrimaryColor,
      //   disabledColor: Color(0x61000000),
      //   highlightColor: Color(0x29000000),
      //   splashColor: Color(0x1f000000),
      //   focusColor: Color(0x1f000000),
      //   hoverColor: Color(0x0a000000),
      // ),
      textTheme: darkModeAppTextTheme(),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        color: Colors.grey[900],
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xff3b404b),
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.white70,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        contentPadding: EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 15,
          right: 15,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        actionTextColor: kWhite,
        contentTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ), bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff424242)),
       switchTheme: SwitchThemeData(
 thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
 if (states.contains(WidgetState.disabled)) { return null; }
 if (states.contains(WidgetState.selected)) { return kPrimaryColor; }
 return null;
 }),
 trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
 if (states.contains(WidgetState.disabled)) { return null; }
 if (states.contains(WidgetState.selected)) { return kPrimaryColor; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
 if (states.contains(WidgetState.disabled)) { return null; }
 if (states.contains(WidgetState.selected)) { return kPrimaryColor; }
 return null;
 }),
 ), checkboxTheme: CheckboxThemeData(
 fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
 if (states.contains(WidgetState.disabled)) { return null; }
 if (states.contains(WidgetState.selected)) { return kPrimaryColor; }
 return null;
 }),
 ),
    );
  }

  late ThemeData lightTheme;
  late ThemeData darkTheme;
}

lightModeAppTextTheme() {
  return const TextTheme(
    titleLarge: TextStyle(
        color: kTextColorsLight,
        fontSize: 64,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    titleMedium: TextStyle(
        color: kTextColorsLight,
        fontFamily: kFontFamily,
        fontSize: 48,
        fontWeight: FontWeight.normal),
    titleSmall: TextStyle(
      color: kTextColorsLight,
      fontSize: 36,
      fontWeight: FontWeight.normal,
      fontFamily: kFontFamily,
    ),
    bodyLarge: TextStyle(
        color: kTextColorsLight,
        fontSize: 30,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(
        color: kTextColorsLight,
        fontSize: 25,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    bodySmall: TextStyle(
        color: kTextColorsLight,
        fontSize: 20,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    displayMedium: TextStyle(
        color: kTextColorsLight,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
  );
}

darkModeAppTextTheme() {
  return  const TextTheme(
    displayLarge:  TextStyle(
        color: kWhite,
        fontFamily: kFontFamily,
        fontSize: 64,
        fontWeight: FontWeight.normal),
    displayMedium:  TextStyle(
        color: kWhite,
        fontSize: 48,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    displaySmall:   TextStyle(
        color: kWhite,
        fontSize: 36,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    headlineMedium:  TextStyle(
        color: kWhite,
        fontSize: 30,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.normal),
    headlineSmall:  TextStyle(
        color: kWhite,
        fontFamily: kFontFamily,
        fontSize: 25,
        fontWeight: FontWeight.normal),
    bodyLarge:  TextStyle(
        color: kWhite,
        fontFamily: kFontFamily,
        fontSize: 20,
        fontWeight: FontWeight.normal),
    bodyMedium:  TextStyle(
        color: kWhite, fontFamily: kFontFamily, fontWeight: FontWeight.normal),
  );
}
