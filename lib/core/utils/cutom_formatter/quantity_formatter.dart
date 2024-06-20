import 'package:flutter/services.dart';

class QuantityFormatter extends TextInputFormatter {
  QuantityFormatter({required this.quantityUnit});
  String quantityUnit;
  RegExp get regExpWithSuffix => RegExp('^[0-9]+(?:\\.[0-9]+)?\\s*$quantityUnit\$');
  RegExp get regExpWithoutSuffix => RegExp(r'^[0-9]+(?:\.[0-9]+)?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if(RegExp('\\.[0-9][0-9]+ $quantityUnit').hasMatch(newValue.text)){
      return oldValue;
    }
    if (regExpWithoutSuffix.hasMatch(newValue.text)) {
      return newValue.copyWith(text: '${newValue.text} $quantityUnit');
    } else if (regExpWithSuffix.hasMatch(newValue.text)) {
      return newValue;
    } else if (newValue.text == ' $quantityUnit') {
      return newValue.copyWith(text: '');
    } else if (regExpWithSuffix.hasMatch(oldValue.text) &&
        oldValue.selection.base.offset !=
            oldValue.text.replaceAll(' $quantityUnit', '').length) {
      return oldValue.copyWith(
        selection: TextSelection.fromPosition(
          TextPosition(offset: oldValue.text.replaceAll(' $quantityUnit', '').length),
        ),
      );
    } else if (!regExpWithSuffix.hasMatch(newValue.text) &&
        regExpWithSuffix.hasMatch(oldValue.text) &&
        newValue.text.endsWith('. $quantityUnit')) {
      if (oldValue.text.length < newValue.text.length) {
        if (newValue.text.contains(RegExp(r'[0-9]\.[0-9]'))) {
          return oldValue;
        } else {
          return newValue;
        }
      } else {
        return TextEditingValue(
          text: '${newValue.text.replaceAll('. $quantityUnit', '')} $quantityUnit',
          selection: TextSelection.collapsed(
              offset: newValue.selection.base.offset - 1),
        );
      }
    }
    return oldValue;
  }
}
