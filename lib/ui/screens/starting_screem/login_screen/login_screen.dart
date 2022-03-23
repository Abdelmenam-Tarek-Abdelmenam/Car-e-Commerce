import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/signup_screen.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/widgtes/back_ground.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/widgtes/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();
  bool showPassText = true;

  LoginScreen({Key? key}) : super(key: key);

  static Page pageRoute() {
    return MaterialPage(
      child: LoginScreen(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              upperText(context),
              textForms(context),
              continueWithSeparator(context),
              googleButton(),
              SizedBox(
                height: 25.r,
              ),
              signUpText(context)
            ],
          ),
        ),
      ),
      reverse: true,
    );
  }

  Widget textForms(BuildContext context) => Form(
        key: loginGlobalKey,
        child: Column(
          children: [
            DefaultFormField(
              controller: emailController,
              fillHint: AutofillHints.email,
              title: "Email",
              prefix: FontAwesomeIcons.user,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email cannot be empty';
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
                  return 'password cannot be empty';
                } else {
                  return null;
                }
              },
              suffix: IconButton(
                icon: Icon(
                  showPassText ? Icons.visibility : Icons.visibility_off,
                  size: 20.r,
                ),
                onPressed: () {
                  // showPassText = !showPassText;
                },
              ),
            ),
            SizedBox(
              height: 25.r,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forget your password ?",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                )
              ],
            ),
            SizedBox(
              height: 50.r,
            ),
            SizedBox(
              width: double.infinity,
              height: 40.r,
              child: ElevatedButton(
                  onPressed: () {
                    if (loginGlobalKey.currentState!.validate()) {}
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      );

  Widget googleButton() => Center(
        child: CircleAvatar(
          radius: 30.r,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.google,
              color: whiteColor,
              size: 25.r,
            ),
            onPressed: () {
              print("Login Using Google");
            },
          ),
        ),
      );

  Widget signUpText(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Not a member?", style: Theme.of(context).textTheme.bodyText1),
          TextButton(
            onPressed: () {
              navigateAndPush(context, SignUpScreen());
            },
            child: Text("Register Now",
                style: Theme.of(context).textTheme.bodyText1),
          )
        ],
      );

  Widget upperText(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 132.r, bottom: 85.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome !",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Sign in",
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      );

  Widget continueWithSeparator(BuildContext context) => Row(
        children: [
          line(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 25.r),
            child: Text("or continue with",
                style: Theme.of(context).textTheme.bodyText2),
          ),
          line()
        ],
      );

  Widget line() => const Expanded(
          child: Divider(
        thickness: 1,
        color: darkGrayColor,
      ));
}

// This is the Painter class
