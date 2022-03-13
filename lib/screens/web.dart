import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puzzle/widgets/animated_dash.dart';
import 'package:puzzle/widgets/animated_timer.dart';
import 'package:puzzle/widgets/background.dart';
import 'package:puzzle/widgets/game.dart';
import 'package:puzzle/widgets/level.dart';
import 'package:puzzle/widgets/puzzle_side_bard.dart';

class WebApp extends StatefulWidget {
  const WebApp({Key? key}) : super(key: key);
  @override
  State<WebApp> createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> with TickerProviderStateMixin {
  late Size _screen;
  double _size = 500;
  bool _isDark = false;

  @override
  void didChangeDependencies() {
    Size screen = MediaQuery.of(context).size;
    _size = screen.width * 0.3;
    if (mounted) {
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _screen = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: _title(),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () => _onThemeChange,
                icon: _isDark
                    ? const Icon(CupertinoIcons.sun_max_fill)
                    : const Icon(CupertinoIcons.moon_stars),
              )
            ],
          ),
          body: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: _screen.width,
                  color: Colors.transparent,
                  child: const PuzzleSideBar(),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Level(),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: _screen.width,
                      child: Center(
                        child: SizedBox(
                          height: _size,
                          width: _size,
                          child: Game(
                            size: _size,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const AnimatedTimer()
                  ],
                ),
              ),
            ],
          ),
        ),
        const AnimatedDash(),
      ],
    );
  }

  Widget _title() {
    return Row(
      children: const <Widget>[
        Text(
          'Flutter Hack',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _onThemeChange() {
    _isDark = !_isDark;
    setState(() {});
  }
}
