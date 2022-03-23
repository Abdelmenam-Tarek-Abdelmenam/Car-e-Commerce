import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/theme.dart';

class LoginBackLayout extends StatelessWidget {
  final Widget child;
  final bool reverse;

  const LoginBackLayout({required this.child, this.reverse = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double diameter = MediaQuery.of(context).size.height.r;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: themeGradient),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: reverse ? 0 : -diameter / 2,
                  right: reverse ? -diameter / 2 : 0,
                  child: CircleAvatar(
                    backgroundColor: veryLightYellow,
                    radius: diameter / 7,
                  ),
                ),
                CustomPaint(
                  painter: MyPainter(reverse),
                  size: Size(diameter, diameter),
                ),
                child,
                Visibility(
                  visible: !reverse,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(22.r),
                      child: CircleAvatar(
                        radius: 22.5.r,
                        child: IconButton(
                          iconSize: 24.r,
                          color: darkGrayColor,
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  bool reverse;
  MyPainter(this.reverse);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = veryLightYellow
      ..strokeWidth = 150
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(
            size.height < 600
                ? -size.height / 1.25
                : (reverse ? 3 : -0.75) * size.height / 4.75,
            size.height / 2),
        height: size.height / 1.2,
        width: size.width * 2,
      ),
      3.14 * .5,
      reverse ? 3.14 : -3.14,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
