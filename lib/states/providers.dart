import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:puzzle/states/app.state.dart';

class Providers {
  static List<SingleChildWidget> providers(context) {
    return [
      ChangeNotifierProvider(
        create: (BuildContext context) => AppState(),
      ),
    ];
  }
}
