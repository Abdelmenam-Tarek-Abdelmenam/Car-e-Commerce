import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

// ignore: must_be_immutable
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
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum',
                image: 'car1',
              ),
              pageBuilder(
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum',
                image: 'car1',
              ),
              pageBuilder(
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum',
                image: 'car1',
              ),
              pageBuilder(
                text:
                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                title: 'Lorem Ipsum',
                image: 'car1',
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
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(4, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(whiteColor)),
                onPressed: () {
                  navigateAndPush(context, const MainScreen());
                },
                child: const Text("Skip"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(whiteColor)),
                onPressed: () {
                  if (page < 3) {
                    liquidController.animateToPage(page: page + 1);
                  } else {
                    navigateAndPush(context, const MainScreen());
                  }
                },
                child: Text(
                  page == 3 ? "Done" : "Next",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget pageBuilder(
      {required String text, required String title, required String image}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: themeGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: CustomPaint(
              painter: ImageBackGround(),
              child: Image.asset(
                "assets/images/OnBoarding/$image.png",
                width: 275,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return SizedBox(
      width: 25.0,
      child: CircleAvatar(
        radius: index == page ? 10.0 : 5.0,
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
      center: Offset(size.width / 2, size.height / 1.4),
      height: 135,
      width: 275,
    ));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
