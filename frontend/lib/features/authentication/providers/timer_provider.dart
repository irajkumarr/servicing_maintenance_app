import 'dart:async';

import 'package:flutter/material.dart';

class ResendTimerProvider extends ChangeNotifier {
  bool _canResendCode = false;
  int _timeLeft = 60; // Changed to 300 seconds (5 minutes)
  Timer? _timer;

  bool get canResendCode => _canResendCode;
  int get timeLeft => _timeLeft;

  // Helper method to format time as MM:SS
  String get formattedTime {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    _canResendCode = false;
    _timeLeft = 60; // Reset to 300 seconds

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _canResendCode = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
