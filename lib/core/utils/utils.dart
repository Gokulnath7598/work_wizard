import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Utils {
  static String getPhoneNumberRegexString({String separator = ' '}) {
    return '^\\d{5}$separator\\d{5}\$';
  }

  static String getFormattedPhoneNumber(
      {required String phoneNumber, String separator = ' '}) {
    return '+91 ${phoneNumber.substring(0, 5)}$separator${phoneNumber.substring(5)}';
  }

  static String getPhoneNumberWithoutCountryCode(String phoneNumber) {
    return phoneNumber
        .replaceAll(RegExp(r' '), '')
        .replaceAll(RegExp(r'^\+91'), '');
  }

  static Future<Map<String, String>> getHeader(String? token) async {
    return <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static bool nullOrEmpty(String? token) {
    return token == null || token == '';
  }

  static String formatPhoneNumber(String phoneNumber) {
    return '+91 ${phoneNumber.substring(0, 5)} ${phoneNumber.substring(
      5,
    )}';
  }

  static bool hasSequentialOrRepetitiveNumbers(String input) {
    final RegExp sequentialPattern = RegExp(
        r'^(?!0123|1234|2345|3456|4567|5678|6789|7890|8901|9012|([0-9])\1{3})[0-9]{4}$');

    return sequentialPattern.hasMatch(input);
  }

  static Size calculateTextSize({
    required String text,
    required TextStyle style,
    BuildContext? context,
  }) {
    final double textScaleFactor = context != null
        ? MediaQuery.of(context).textScaler.scale(style.fontSize!)
        : WidgetsBinding.instance.platformDispatcher.textScaleFactor;

    final TextDirection textDirection =
        context == null ? TextDirection.ltr : Directionality.of(context);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      textScaler: TextScaler.linear(textScaleFactor),
    )..layout();

    return textPainter.size;
  }

  static Size? getWidgetSize(GlobalKey key) {
    if (key.currentState != null &&
        key.currentContext!.findRenderObject() != null) {
      final RenderBox renderBox =
          key.currentContext!.findRenderObject()! as RenderBox;
      return renderBox.size;
    }
    return null;
  }
}

extension CustomDoubleExtension on double {
  String get currencyCompactFormat {
    return intl.NumberFormat.compactCurrency(
            locale: 'en_IN', name: '₹ ', decimalDigits: 2)
        .format(this);
  }

  String get currencyFormat {
    return intl.NumberFormat.currency(
            locale: 'en_IN', name: '', symbol: '', decimalDigits: 0)
        .format(this);
  }

  String get currencyFormatWithSymbolAndDecimal {
    return intl.NumberFormat.currency(locale: 'en_IN', symbol: '₹ ')
        .format(this);
  }

  String get currencyFormatWithSymbol {
    return intl.NumberFormat.currency(
            locale: 'en_IN', symbol: '₹ ', decimalDigits: 0)
        .format(this);
  }

  String get compactCurrencyWith1Decimal {
    return intl.NumberFormat.compactCurrency(
            locale: 'en_IN', name: '₹ ', decimalDigits: 1)
        .format(this)
        .replaceAll('T', 'K');
  }

  String get expandedCompactCurrencyWith1Decimal {
    return compactCurrencyWith1Decimal
        .replaceAll('K', ' Thousands')
        .replaceAll('L', ' Lakhs')
        .replaceAll('C', ' Crores');
  }
}

extension CustomDateTimeExtension on DateTime {
  String get customDdMmmYyFormat {
    return intl.DateFormat('dd MMM ‘yy').format(this);
  }

  String get customDdMmmYyyyFormat {
    return intl.DateFormat('dd MMM yyyy').format(this);
  }

  String get customYyyyMmDdFormat {
    return intl.DateFormat('yyyy-MM-dd').format(this);
  }
}
