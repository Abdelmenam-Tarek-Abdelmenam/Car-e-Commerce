import 'package:flutter/material.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({ Key? key }) : super(key: key);

  static Page pageRoute() {
    return MaterialPage(
      child: SignScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hey Sign'),
    );
  }
}