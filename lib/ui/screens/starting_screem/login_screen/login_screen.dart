import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/signup_screen.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/widgtes/back_ground.dart';
import 'package:car_e_commerce/ui/screens/starting_screem/login_screen/widgtes/form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();

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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome !",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "Sign in",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Form(
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
                    const SizedBox(
                      height: 20,
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
                        icon: const Icon(
                            true ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          // showPassText = !showPassText;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget your password ?",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
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
              ),
              Row(
                children: [
                  line(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 40),
                    child: Text("or continue with",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  line()
                ],
              ),
              Center(
                child: CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      print("Login Using Google");
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",
                      style: Theme.of(context).textTheme.bodyText1),
                  TextButton(
                    onPressed: () {
                      navigateAndPush(context, SignUpScreen());
                    },
                    child: Text("Register Now",
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      reverse: true,
    );
  }

  Widget line() => const Expanded(
          child: Divider(
        thickness: 1,
        color: darkGrayColor,
      ));
}

// This is the Painter class
