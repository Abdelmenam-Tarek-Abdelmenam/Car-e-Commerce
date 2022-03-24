import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/shared/widgets/custom_button.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/widgtes/back_ground.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/widgtes/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckerController = TextEditingController();
  GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();
  bool showPassText = true;

  SignUpScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return MaterialPage(
      child: SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoginBackLayout(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 42.r),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 118.r, bottom: 63.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "Let's ",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Form(
                key: signUpGlobalKey,
                child: Column(
                  children: [
                    DefaultFormField(
                      controller: emailController,
                      fillHint: AutofillHints.email,
                      title: "Email",
                      prefix: FontAwesomeIcons.user,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '    Email cannot be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 36.r,
                    ),
                    DefaultFormField(
                      controller: passController,
                      fillHint: AutofillHints.password,
                      title: "Password",
                      prefix: Icons.lock_open,
                      isPass: !true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '    Password cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      suffix: IconButton(
                        icon: Icon(showPassText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          // showPassText = !showPassText;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 36.r,
                    ),
                    DefaultFormField(
                      controller: passCheckerController,
                      fillHint: AutofillHints.password,
                      title: "Confirm password",
                      prefix: Icons.lock_open,
                      isPass: !true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '    Password cannot be empty';
                        } else if (value != passController.text) {
                          return "    Passwords must be the same";
                        } else {
                          return null;
                        }
                      },
                      suffix: IconButton(
                        icon: Icon(showPassText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          // showPassText = !showPassText;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 45.r, bottom: 60.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Interests",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(
                            height: 10.r,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: interestsList()),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40.r,
                      child: ElevatedButton(
                          onPressed: () {
                            if (signUpGlobalKey.currentState!.validate()) {}
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(fontSize: 20),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?",
                      style: Theme.of(context).textTheme.bodyText1),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Log in",
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      reverse: false,
    );
  }

  List<Widget> interestsList() {
    return List.generate(
        4,
        (index) => CustomChooseButton(
            active: index == 1,
            child: index == 0
                ? Text("ALL",
                    style: TextStyle(fontSize: 15.r, color: whiteColor))
                : Icon(
                    [
                      FontAwesomeIcons.car,
                      FontAwesomeIcons.motorcycle,
                      FontAwesomeIcons.bicycle
                    ][index - 1],
                    color: whiteColor,
                    size: 24.r,
                  ),
            onPressed: () => print("set $index")));
  }
}

// This is the Painter class
