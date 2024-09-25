import 'dart:io';

import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:intl/intl.dart';


// typedef ToolbarOptionModelCallback = void Function(ToolbarOptionModel sortModel);

const String kCompanyName = 'Travoli';
const String kAppVersion = '1.0.0';

/// Default theme font.  LengthLimitingTextInputFormatter(11),

const String kDummyEmail = "johndoe@gmail.com";
const String kDummyName = "John Doe";
const String kDummyPassword = "johndoe#123";
const String kCurrency = '\u20A6';

const String kFontFamily = "Roboto";
const String kSecondaryFontFamily = "Lato";

// Date/time formats
const String kDateFormat = 'dd/MM/yyyy';
const String kDateTimeFormat = 'dd/MM/yyyy HH:mm';
const String kTimeFormat = 'HH:mm';

// currency
String localCurrency() {
  var format = NumberFormat.simpleCurrency(
    locale: Platform.localeName,
  );
  return format.currencySymbol;
}

  const  String currencySymbol = "₦";
  const  String customAmount = "₦300,000";

//! Various Sizes
double kBottomBarIconSize = 32;
const double kBoxDecorationRadius = 8.0;
const double kFormFieldsRadius = 6.0;
const double kRoundedButtonRadius = 24.0;
const double kCardRadius = 24.0;
const double kBadgeRadius = 16.0;
const double kTimelineDateSize = 88.0;
const double kBorderRadius = 10.0;
const double kBottomNavBarHeight = 60.0;

//! Colors
const Color kPrimaryColor = Color(0xffF000000);
const Color lightScaffoldBackgroundColor = Color(0xffFFFDF7);
const Color kTextColorsLight = Color(0xFF100C08);
const Color navBarIconsInActiveColor = Color(0xff98A2B3);
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF000000);
const Color kError = Color(0xFFF04438);
const Color kGrey = Color(0xff5B6C7C);
const Color kWarning = Color(0xfff79009);
const Color kTransparent = Colors.transparent;
const Color kSuccess = Color(0xFF12B76A);

// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;
const double kScreenPadding = 20;

// Avatar sizes
const double kCircleAvatarSizeRadiusAppBar = 20.0;
const double kCircleAvatarSizeRadiusSmall = 24.0;
const double kCircleAvatarSizeRadiusLarge = 48.0;

// Animations
const Duration kRippleAnimationDuration = Duration(milliseconds: 600);
const Duration kButtonAnimationDuration = Duration(milliseconds: 200);
const Duration kPaymentCardAnimationDuration = Duration(milliseconds: 500);

/// Minimal query string length.
const int kMinimalNameQueryLength = 3;

/// Minimal password string length.
const int kMinimalPasswordLength = 7;

/// SnackBar duration in milliseconds (short).
const int kSnackBarDurationShort = 2500;

/// SnackBar duration in milliseconds (long).
const int kSnackBarDurationLong = 10000;

/// Password match regex string.
/* r'^
//
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])      // should contain at least one digit
  (?=.*?[!@#/$&*~]) // should contain at least one Special character
  .{8,}             // Must be at least 8 characters in length  
$
*/
// bool validateStructure(String value) {
//   String pattern =
//       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#/$&*~]).{8,}$';
//   RegExp regExp = RegExp(pattern);
//   return regExp.hasMatch(value);
// }

// const String kPasswordRegex =
//     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#/$&*~]).{8,}$';

double kScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double kScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

CurrencyFormat nairaSettings = const CurrencyFormat(
  symbol: '₦',
  symbolSide: SymbolSide.left,
  thousandSeparator: ',',
  decimalSeparator: '.',
  symbolSeparator: "",
);





