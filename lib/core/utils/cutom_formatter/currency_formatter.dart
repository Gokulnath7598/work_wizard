import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    TextEditingValue textEditingValue;
    int? decimalDigits;
    if (newValue.text.contains(RegExp(r'[^0-9.,]'))) {
      textEditingValue = oldValue;
    } else {
      if (oldValue.text.length > newValue.text.length &&
          newValue.text.endsWith('.')) {
        decimalDigits = null;
      } else if (newValue.text.contains('.')) {
        decimalDigits =
            newValue.text.substring(newValue.text.indexOf('.') + 1).length;
      }
      if (decimalDigits != null && decimalDigits > 2) {
        textEditingValue = TextEditingValue(
          text: oldValue.text,
        );
        decimalDigits = 2;
      } else {
        textEditingValue = TextEditingValue(
          text: newValue.text,
        );
      }
    }
    final double? amount = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '',
      name: '',
      decimalDigits: decimalDigits ?? 0,
    ).tryParse(textEditingValue.text) as double?;
    final String formattedAmount = (amount != null)
        ? NumberFormat.currency(
            locale: 'en_IN',
            symbol: '',
            name: '',
            decimalDigits: decimalDigits ?? 0,
          ).format(amount)
        : '';
    return TextEditingValue(
      text: amount != null
          ? '$formattedAmount${decimalDigits == 0 ? '.' : ''}'
          : '',
    );
  }
}
