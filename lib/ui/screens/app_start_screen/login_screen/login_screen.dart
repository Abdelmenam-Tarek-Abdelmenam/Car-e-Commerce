import 'package:car_e_commerce/ui/screens/app_start_screen/login_screen/widgtes/main_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return const MaterialPage(
      child: LoginScreen(),
    );
  }

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backGroundBlue,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                topWidget(),
                const SizedBox(
                  height: 40,
                ),
                const MainLoginWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Cars APP",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: foreGroundBlue),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Are you ready to explore enjoy exploring cars ..?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: foreGroundBlue),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
