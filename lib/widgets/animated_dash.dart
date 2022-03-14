import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedDash extends StatefulWidget {
  final double? size;
  const AnimatedDash({Key? key, this.size}) : super(key: key);

  @override
  State<AnimatedDash> createState() => _AnimatedDashState();
}

class _AnimatedDashState extends State<AnimatedDash> {
  double _dashBottom = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dashBottom = _dashBottom == 0 ? 30 : 0;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: _dashBottom,
      left: 30,
      child: SizedBox(
        height: widget.size ?? 200,
        width: widget.size ?? 200,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            'assets/images/dash.png',
          ),
        ),
      ),
    );
  }
}
