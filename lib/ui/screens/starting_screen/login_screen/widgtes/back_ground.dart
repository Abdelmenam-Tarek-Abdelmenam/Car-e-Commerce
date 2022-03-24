import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/theme.dart';
import '../../../../../shared/widgets/bar_icon_button.dart';

class LoginBackLayout extends StatelessWidget {
  final Widget child;
  final bool reverse;

  const LoginBackLayout({required this.child, this.reverse = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double diameter = MediaQuery.of(context).size.height.r;
    print(reverse);
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
              alignment: reverse ? Alignment.centerRight : Alignment.centerLeft,
              children: [
                Positioned(
                  left: reverse ? null : -diameter / 7,
                  right: reverse ? -diameter / 7 : null,
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
                      child: BarIconButton(
                          icon: Icons.arrow_back_rounded,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
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
      ..strokeWidth = size.height < 600 ? 50 : 150
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(
            size.height < 600
                ? size.width * 1.5
                : (reverse ? 3 : -0.75) * size.height / 4.75,
            size.height / 2),
        height: size.height,
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
