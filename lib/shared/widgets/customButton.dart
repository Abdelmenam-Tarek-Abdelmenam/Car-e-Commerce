import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/theme.dart';

class CustomChooseButton extends StatelessWidget {
  final void Function() onPressed;
  final bool active;
  final Widget child;

  const CustomChooseButton(
      {required this.active,
      required this.child,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: active ? darkYellow : darkGrayColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: child,
          )),
    );
  }
}
