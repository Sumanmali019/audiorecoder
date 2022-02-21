import 'dart:async';

import 'package:flutter/material.dart';

class TimeController extends ValueNotifier<bool> {
  TimeController({bool isPlaying = false}) : super(isPlaying);

  void startTimer() => value = true;
  void stopTimer() => value = false;
}

class TimeWidget extends StatefulWidget {
  final TimeController controller;

  const TimeWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  Duration duration = const Duration();
  static const maxSeconds = 50;
  int seconds = maxSeconds;

  Timer? timer;
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.value) {
        startTimer();
      } else {
        stopTimer();
      }
    });
  }

  void reset() => setState(() => duration = const Duration());

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }

    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) => Center(
        child: buildTime(),
      );

  Widget buildTime() {
    return Text(
      '${duration.inSeconds}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 80,
      ),
    );
  }
}
