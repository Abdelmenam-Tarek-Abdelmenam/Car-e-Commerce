import 'package:flutter/material.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return const MaterialPage(
      child: SignScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const Text('Hey Sign'));
  }
}
