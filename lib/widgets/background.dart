import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puzzle/consts/colors.dart';
import 'package:puzzle/widgets/animated_snow.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with TickerProviderStateMixin {
  bool isImageLoaded = false;
  late ui.Image image;
  late Size screen;
  List<AnimatedSnow> snows = [];

  @override
  void initState() {
    _loadImage();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    screen = MediaQuery.of(context).size;
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      AnimatedSnow snow = AnimatedSnow(
        height: screen.height,
        top: _getRandom(screen.height.toInt()),
        left: _getRandom(screen.width.toInt()),
      );
      snows.add(snow);
      setState(() {});
    });
    super.didChangeDependencies();
  }

  _loadImage() async {
    final data = await rootBundle.load('assets/images/bg.jpg');
    final bytes = data.buffer.asUint8List();
    image = await decodeImageFromList(bytes);
    setState(() {
      isImageLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    return isImageLoaded
        ? Container(
            height: screen.height,
            width: screen.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(AppColors.sky1), Color(AppColors.sky2)],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: CustomPaint(
                    size: Size(image.width.toDouble(), image.height.toDouble()),
                    painter: ImagePainter(image: image),
                  ),
                ),
                SizedBox(
                  height: screen.height,
                  width: screen.width,
                  child: Stack(
                    children: snows,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  double _getRandom(int max) {
    return Random().nextInt(max).toDouble();
  }
}

class ImagePainter extends CustomPainter {
  ui.Image image;
  ImagePainter({required this.image});
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()..blendMode = ui.BlendMode.softLight;
    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(CustomPainter val) => false;
}
