// ignore: must_be_immutable

import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../login_screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return const MaterialPage(
      child: OnBoardingScreen(),
    );
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  LiquidController liquidController = LiquidController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            pages: [
              pageBuilder(
                color: const Color(0xFFFED154),
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum 1',
                image: 'car1',
              ),
              pageBuilder(
                color: const Color(0XFFF4B301),
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum 2',
                image: 'car2',
              ),
              pageBuilder(
                color: const Color(0XFFF5A302),
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum 3',
                image: 'car3',
              ),
            ],
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            waveType: WaveType.liquidReveal,
            onPageChangeCallback: (currentPage) {
              setState(() {
                page = currentPage;
              });
            },
            enableLoop: false,
            liquidController: liquidController,
            enableSideReveal: true,
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(3, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(25.r),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(whiteColor)),
                onPressed: () {
                  navigateAndPush(context, LoginScreen());
                },
                child: const Text("Skip"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(25.r),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(whiteColor)),
                onPressed: () {
                  if (page < 2) {
                    liquidController.animateToPage(page: page + 1);
                  } else {
                    navigateAndPush(context, LoginScreen());
                  }
                },
                child: Text(
                  page == 2 ? "Done" : "Next",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget pageBuilder(
      {required Color color,
      required String text,
      required String title,
      required String image}) {
    return Container(
      width: double.infinity,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 200.h,
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: CustomPaint(
                painter: ImageBackGround(),
                child: Image.asset(
                  "assets/images/OnBoarding/$image.png",
                  width: 275.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: darkGrayColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return SizedBox(
      width: 30.w,
      child: CircleAvatar(
        radius: index == page ? 8.r : 4.r,
      ),
    );
  }
}

class ImageBackGround extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = whiteColor
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 1.2),
      height: 120.h,
      width: 275.w,
    ));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
