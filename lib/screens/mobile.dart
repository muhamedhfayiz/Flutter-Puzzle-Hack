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

class MobileApp extends StatefulWidget {
  const MobileApp({Key? key}) : super(key: key);
  @override
  State<MobileApp> createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> with TickerProviderStateMixin {
  late Size _screen;
  double _size = 500;
  bool _isDark = false;

  @override
  void didChangeDependencies() {
    Size screen = MediaQuery.of(context).size;
    _size = screen.width;
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
                onPressed: () => _onThemeChange(),
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
                    const AnimatedTimer(),
                    _status(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const AnimatedDash(size: 50),
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
    final AppState appState = Provider.of<AppState>(context, listen: false);
    _isDark = !_isDark;
    if (_isDark) {
      appState.setMode(true);
    } else {
      appState.setMode(false);
    }
    setState(() {});
  }

  Widget _status() {
    final AppState appState = Provider.of<AppState>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${appState.moves} Moves | ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: appState.darkMode
                ? Colors.white
                : const Color(AppColors.darkBlue),
          ),
        ),
        Text(
          '${appState.tile} Tiles',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: appState.darkMode
                ? Colors.white
                : const Color(AppColors.darkBlue),
          ),
        ),
      ],
    );
  }
}
