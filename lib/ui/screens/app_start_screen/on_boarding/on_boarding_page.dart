import 'dart:math';

import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/app_start_screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

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
  TextStyle style = const TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  LiquidController liquidController = LiquidController();
  int page = 0;
  Widget _buildDot(int index) {
    double selected = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selected;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.blueGrey,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            pages: [
              pageBuilder(
                  color: const Color(0xFFDEECF8),
                  text: "Hi user in our Application we are happy to see ypu",
                  lottie: "car1"),
              pageBuilder(
                  color: const Color(0xFFF1F9FF),
                  text: "Hi user in our Application we are happy to see ypu",
                  lottie: "car2"),
              pageBuilder(
                  color: const Color(0xFFDEECF8),
                  text: "Hi user in our Application we are happy to see ypu",
                  lottie: "motorcycle1"),
              pageBuilder(
                  color: const Color(0xFFF1F9FF),
                  text: "Hi user in our Application we are happy to see ypu",
                  lottie: "motorcycle2"),
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
              child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                onPressed: () {
                  navigateAndPush(context, const LoginScreen());
                },
                child: const Text("Skip"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                onPressed: () {
                  if (page < 3) {
                    liquidController.animateToPage(page: page + 1);
                  } else {
                    navigateAndPush(context, const LoginScreen());
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
      {required Color color, required String text, required String lottie}) {
    return Container(
      width: double.infinity,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Lottie.asset("assets/lottie/" + lottie + ".zip",
              fit: BoxFit.fill, height: 300),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              text,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
