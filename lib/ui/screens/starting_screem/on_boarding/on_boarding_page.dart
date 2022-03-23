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
  TextStyle style = const TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

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
                text: "Hi user in our Application we are happy to see ypu",
                title: 'Lorem Ipsum',
              ),
              pageBuilder(
                text: "Hi user in our Application we are happy to see ypu",
                title: 'Lorem Ipsum',
              ),
              pageBuilder(
                text: "Hi user in our Application we are happy to see ypu",
                title: 'Lorem Ipsum',
              ),
              pageBuilder(
                text: "Hi user in our Application we are happy to see ypu",
                title: 'Lorem Ipsum',
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

  Widget pageBuilder({required String text, required String title}) {
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
          const FlutterLogo(
            size: 150,
          ),
          Text(title),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              text,
              style: style,
            ),
          ),
          const SizedBox()
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
