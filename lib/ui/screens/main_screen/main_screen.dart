
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  // static route page
  static Page pageRoute() {
    return MaterialPage(
      child: MainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('main'),
    );
  }
}
