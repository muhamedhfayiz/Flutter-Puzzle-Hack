import 'dart:async';

import 'package:flutter/material.dart';
import 'package:puzzle/consts/colors.dart';

class AnimatedTimer extends StatefulWidget {
  const AnimatedTimer({Key? key}) : super(key: key);

  @override
  State<AnimatedTimer> createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer> {
  double _rotate = 0;
  num hour = 0;
  num minute = 0;
  num second = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (val) {
      if (mounted) {
        setState(() {
          _rotate = _rotate + 0.5;
          second = second + 1;
          if (second == 60) {
            second = 0;
            minute++;
          }
          if (minute == 60) {
            minute = 0;
            hour++;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')}',
          style: const TextStyle(
            color: Color(AppColors.darkBlue),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        AnimatedRotation(
          turns: _rotate,
          duration: const Duration(milliseconds: 500),
          child: const Icon(
            Icons.hourglass_top_rounded,
            color: Color(AppColors.darkBlue),
            size: 30,
          ),
        ),
      ],
    );
  }
}
