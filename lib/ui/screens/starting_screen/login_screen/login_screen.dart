import 'dart:ui';

import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/ui/routes/navigation_functions.dart';
import 'package:car_e_commerce/ui/screens/main_screen/main_screen.dart';
import 'package:car_e_commerce/ui/screens/starting_screen/login_screen/signup_screen.dart';
import 'package:car_e_commerce/ui/screens/starting_screen/login_screen/widgtes/back_ground.dart';
import 'package:car_e_commerce/ui/screens/starting_screen/login_screen/widgtes/forget_password.dart';
import 'package:car_e_commerce/ui/screens/starting_screen/login_screen/widgtes/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();
  // final AuthRepository _auth = AuthRepository();

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
        padding: EdgeInsets.symmetric(horizontal: 42.w),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              upperText(context),
              textForms(context),
              continueWithSeparator(context),
              googleButton(context),
              SizedBox(
                height: 25.h,
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
                  return '    Email cannot be empty';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 36.h,
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
                icon: Icon(
                  showPassText ? Icons.visibility : Icons.visibility_off,
                  size: 20.r,
                ),
                onPressed: () {
                  showPassText = !showPassText;
                  // context.read<LoginCubit>().changeShowPasswordState();
                },
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                              child: ForgetPassword(),
                              //  contentPadding: const EdgeInsets.all(0.0),
                            ),
                          );
                        });
                  },
                  child: Text(
                    "Forget your password ?",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              // state.status == LoginStatus.submittingEmail
              //             ? const CircularProgressIndicator()
              child: ElevatedButton(
                  onPressed: () {
                    if (loginGlobalKey.currentState!.validate()) {
                      // context.read<LoginCubit>().emailChange(emailController.text);
                      // context.read<LoginCubit>().passwordChange(passController.text);
                      // context
                      //     .read<LoginCubit>()
                      //     .signInWithFirebaseByEmailAndPassword();
                    }
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 20.sp),
                  )),
            )
          ],
        ),
      );

  //  state.status == LoginStatus.submittingGoogle
  //             ? const CircularProgressIndicator()
  Widget googleButton(BuildContext context) => Center(
        child: CircleAvatar(
          radius: 30.r,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.google,
              color: whiteColor,
              size: 25.r,
            ),
            onPressed: () {
              navigateAndPush(context, const MainScreen());
              // context.read<LoginCubit>().signInWithGoogle()
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
        padding: EdgeInsets.only(top: 132.h, bottom: 85.h),
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
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 25.h),
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
