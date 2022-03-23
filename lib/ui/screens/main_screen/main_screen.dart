import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static Page pageRoute() {
    return const MaterialPage(
      child: MainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
