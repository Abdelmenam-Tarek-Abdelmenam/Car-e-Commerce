import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          key: UniqueKey(),
          width: 65.w,
          height: 65.h,
          decoration: BoxDecoration(
              color: active ? darkYellow : darkGrayColor,
              borderRadius: BorderRadius.all(Radius.circular(13.r))),
          child: Center(
            child: child,
          )),
    );
  }
}
