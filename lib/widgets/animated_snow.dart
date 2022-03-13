import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AnimatedSnow extends StatefulWidget {
  final double top;
  final double left;
  final double height;
  const AnimatedSnow({
    Key? key,
    required this.top,
    required this.left,
    required this.height,
  }) : super(key: key);

  @override
  State<AnimatedSnow> createState() => _AnimatedSnowState();
}

class _AnimatedSnowState extends State<AnimatedSnow>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late Size screen;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween<double>(begin: widget.top, end: widget.height)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.dispose();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    double radius = getRadius();
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Positioned(
                top: animation.value,
                left: widget.left,
                child: Opacity(
                  opacity: calculateOpacity(screen.height, animation.value),
                  child: CustomPaint(
                    size: Size(screen.width, screen.height),
                    painter: SnowPainter(radius: radius),
                  ),
                )),
          ],
        );
      },
    );
  }

  double calculateOpacity(max, curentValue) {
    double scrollPercentage = curentValue / max;
    double opacity = 1 - double.parse(scrollPercentage.toStringAsFixed(1));
    return opacity;
  }
}

class SnowPainter extends CustomPainter {
  double radius;
  SnowPainter({required this.radius});
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..blendMode = ui.BlendMode.softLight
      ..color = Colors.white
      ..strokeWidth = 10;
    canvas.drawCircle(Offset(radius * 2, radius * 2), radius, paint);
    canvas.drawCircle(Offset(radius + (radius * 2), radius * 2), radius, paint);
    canvas.drawCircle(
        Offset((radius / 2) + (radius * 2), radius + (radius * 2)),
        radius,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter val) => false;
}

double getRadius() {
  List<int> radius = [4, 6, 8, 10, 12];
  return radius[Random().nextInt(5)].toDouble();
}
