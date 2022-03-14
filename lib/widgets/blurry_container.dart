import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:puzzle/consts/colors.dart';

class BlurryContainer extends StatelessWidget {
  final double? blur;
  final double? height, width;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final String value;

  const BlurryContainer({
    Key? key,
    this.blur = 5,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(16),
    this.bgColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 0, sigmaY: blur ?? 0),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          child: Center(
              child: Text(
            value,
            style: TextStyle(
              fontSize: height! * 0.3,
              fontWeight: FontWeight.bold,
              color: const Color(AppColors.darkBlue),
            ),
          )),
          decoration: BoxDecoration(
            color: bgColor == Colors.transparent
                ? bgColor
                : bgColor?.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withOpacity(0.3),
                offset: Offset(0, height! - 40),
                blurRadius: 10,
                spreadRadius: -10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
