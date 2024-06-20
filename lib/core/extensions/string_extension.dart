import 'package:intl/intl.dart';

import '../utils/utils.dart';

extension StringExtension on String {
  String capitalizeByWord() {
    if (trim().isEmpty) {
      return '';
    }
    return split(' ')
        .map((String element) =>
            '${element[0].toUpperCase()}${element.substring(1).toLowerCase()}')
        .join(' ');
  }

  String camelToSentence() {
    final String result = replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r' ');
    final String finalResult = result[0].toUpperCase() + result.substring(1);
    return finalResult;
  }

  String inRupeesFormat() {
    return NumberFormat.currency(
      name: 'INR',
      locale: 'en_IN',
      decimalDigits: 2, // change it to get decimal places
      symbol: '₹ ',
    ).format(double.tryParse(this));
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  String? get snakeCaseToCapitalizedText {
    if (!isNullOrEmpty && this!.contains('_')) {
      return this!
          .trim()
          .split('_')
          .map((String str) => '${str[0].toUpperCase()}${str.substring(1)}')
          .join(' ');
    } else {
      return '${this?[0].toUpperCase()}${this?.substring(1)}';
    }
  }

  String? get maskedAccountNumberFormat {
    if (!isNullOrEmpty) {
      return 'a/c xxxx ${this!.substring(this!.length - 4)}';
    }
    return null;
  }

  double get parseAsDouble {
    if (!isNullOrEmpty) {
      return double.parse(this!);
    }
    return 0;
  }

  bool isValidEmail() {
    if (this == null || this == '') {
      return false;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this ?? '');
  }

  String getFirstLetters() {
    if (Utils.nullOrEmpty(this)) {
      return '';
    }

    final List<String>? words = this?.split(' ');

    if (words?.length == 1) {
      return words![0].substring(0, 1);
    } else {
      return words!
          .map((String word) => word.substring(0, 1))
          .join()
          .substring(0, 2);
    }
  }
}
