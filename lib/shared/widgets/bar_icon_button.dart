import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/theme.dart';

class BarIconButton extends StatelessWidget {
  const BarIconButton({required this.icon, required this.onPressed, Key? key})
      : super(key: key);

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22.5.r,
      child: IconButton(
        iconSize: 24.r,
        color: darkGrayColor,
        icon: Icon(
          icon,
          color: whiteColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
