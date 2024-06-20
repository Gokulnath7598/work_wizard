import 'dart:async';

class MyTimer {
  Timer? _timer;
  int _resendSeconds = 30;
  void Function(int)? setStateCallback;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _resendSeconds--;
      if (_resendSeconds == 0) {
        stopTimer();
      }
      if (setStateCallback != null) {
        setStateCallback!(_resendSeconds);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void setResendSeconds(int seconds) {
    _resendSeconds = seconds;
    if (setStateCallback != null) {
      setStateCallback!(_resendSeconds);
    }
  }
}
