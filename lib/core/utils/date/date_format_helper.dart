import 'package:intl/intl.dart';

class DateFormatHelper {
  static String formatDOBDate({required String? time}) {
    if (time != null && time != '') {
      final DateTime time0 = DateTime.parse(time);
      return DateFormat('dd MMM yyyy').format(time0);
    } else {
      return '';
    }
  }

  static String dobDateFormat({required String? time}) {
    if (time != null && time != '') {
      final DateTime time0 = DateTime.parse(time);
      return DateFormat('yyyy-MM-dd').format(time0);
    } else {
      return '';
    }
  }
}

class TimeFormatHelper {
  static String formatSeconds(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}
