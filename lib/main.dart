import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/screens/mobile.dart';
import 'package:puzzle/screens/web.dart';
import 'package:puzzle/states/providers.dart';

class ScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Puzzle Hack',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _getHomeScreen(),
        scrollBehavior: ScrollBehavior(),
      ),
    );
  }

  Widget _getHomeScreen() {
    if (kIsWeb) {
      return const WebApp();
    } else {
      if (Platform.isAndroid) {
        return const MobileApp();
      } else if (Platform.isIOS) {
        return const MobileApp();
      } else {
        return const WebApp();
      }
    }
  }
}
