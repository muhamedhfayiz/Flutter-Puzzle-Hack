import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/consts/colors.dart';
import 'package:puzzle/states/app.state.dart';
import 'package:puzzle/widgets/animated_dash.dart';
import 'package:puzzle/widgets/animated_timer.dart';
import 'package:puzzle/widgets/background.dart';
import 'package:puzzle/widgets/puzzle.dart';
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
  bool _isAppLoaded = false;
  double _logoScale = 1.0;

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _logoScale = 1.3;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Size screen = MediaQuery.of(context).size;
    _size = screen.width * 0.3;
    if (_size > 500) {
      _size = _size;
    } else {
      _size = 500;
    }
    if (mounted) {
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _isAppLoaded = true;
        });
      });
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
                onPressed: () => _onThemeChange(),
                icon: _isDark
                    ? const Icon(CupertinoIcons.sun_max_fill, size: 30)
                    : const Icon(CupertinoIcons.moon_stars_fill, size: 30),
              ),
              const SizedBox(width: 20),
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
                          child: Puzzle(size: _size),
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
        _appLoader(),
      ],
    );
  }

  Widget _appLoader() {
    if (!_isAppLoaded) {
      return Container(
        height: _screen.height,
        width: _screen.width,
        color: const Color(AppColors.darkBlue),
        child: Center(
          child: AnimatedScale(
            scale: _logoScale,
            duration: const Duration(seconds: 1),
            child: FlutterLogo(size: _screen.width * 0.1),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _title() {
    return Row(
      children: const <Widget>[
        Text(
          'Flutter Puzzle Hack',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _onThemeChange() {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    _isDark = !_isDark;
    if (_isDark) {
      appState.setMode(true);
    } else {
      appState.setMode(false);
    }
    setState(() {});
  }
}
