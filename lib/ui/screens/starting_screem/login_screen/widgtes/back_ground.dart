import 'package:flutter/material.dart';

import '../../../../../constants/theme.dart';

class LoginBackLayout extends StatelessWidget {
  final Widget child;
  final bool reverse;

  const LoginBackLayout({required this.child, this.reverse = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double diameter = MediaQuery.of(context).size.height;
    print(diameter);
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
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        child: IconButton(
                          iconSize: 20,
                          splashRadius: 30,
                          color: darkGrayColor,
                          icon: const Icon(
                            Icons.arrow_back_ios,
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
      ..strokeWidth = 100
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(
            size.height < 600
                ? -size.height / 1.25
                : (reverse ? 3 : -0.75) * size.height / 5,
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
