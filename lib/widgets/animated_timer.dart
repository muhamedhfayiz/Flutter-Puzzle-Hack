import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/consts/colors.dart';
import 'package:puzzle/states/app.state.dart';

class AnimatedTimer extends StatefulWidget {
  const AnimatedTimer({Key? key}) : super(key: key);

  @override
  State<AnimatedTimer> createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer> {
  double _rotate = 0;
  num second = 0;
  late Timer timer;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      AppState appState = Provider.of<AppState>(context, listen: false);
      Timer.periodic(const Duration(seconds: 1), (val) {
        if (mounted) {
          setState(() {
            _rotate = _rotate + 0.5;
            second = second + 1;
            appState.setTime(second);
          });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context, listen: true);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${appState.hour.toString().padLeft(2, '0')} : ${appState.minute.toString().padLeft(2, '0')} : ${appState.second.toString().padLeft(2, '0')}',
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
          child: Icon(
            _rotate.toInt().isEven
                ? Icons.hourglass_top_rounded
                : Icons.hourglass_bottom_rounded,
            color: const Color(AppColors.darkBlue),
            size: 30,
          ),
        ),
      ],
    );
  }
}
