import 'package:car_e_commerce/constants/theme.dart';
import 'package:car_e_commerce/shared/widgets/custom_button.dart';
import 'package:car_e_commerce/shared/widgets/toast_helper.dart';
import 'package:car_e_commerce/ui/screens/starting_screen/login_screen/widgtes/back_ground.dart';
import 'package:car_e_commerce/ui/screens/starting_screen/login_screen/widgtes/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../bloc/cubit/login_handler/login_cubit.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckerController = TextEditingController();
  GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();
  bool showPassText1 = true;
  bool showPassText2 = true;

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
                padding: EdgeInsets.only(top: 118.h, bottom: 63.h),
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
                child: BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return Column(
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
                          isPass: showPassText1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '    Password cannot be empty';
                            } else {
                              return null;
                            }
                          },
                          suffix: IconButton(
                            icon: Icon(showPassText1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              showPassText1 = !showPassText1;
                              context
                                  .read<LoginCubit>()
                                  .changeShowPasswordState();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        DefaultFormField(
                          controller: passCheckerController,
                          fillHint: AutofillHints.password,
                          title: "Confirm password",
                          prefix: Icons.lock_open,
                          isPass: showPassText2,
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
                            icon: Icon(showPassText2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              showPassText2 = !showPassText2;
                              context
                                  .read<LoginCubit>()
                                  .changeShowPasswordState();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 45.h, bottom: 60.h),
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
                              interestsList(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40.h,
                          child: ElevatedButton(
                              onPressed: () {
                                if (signUpGlobalKey.currentState!.validate()) {
                                  context
                                      .read<LoginCubit>()
                                      .emailChange(emailController.text);
                                  context
                                      .read<LoginCubit>()
                                      .passwordChange(passController.text);
                                  context
                                      .read<LoginCubit>()
                                      .signUpWithFirebaseByEmailAndPassword();
                                }
                              },
                              child: state.status == LoginStatus.submittingEmail
                                  ? const LinearProgressIndicator(
                                      color: whiteColor,
                                    )
                                  : Text(
                                      "Sign up",
                                      style: TextStyle(fontSize: 20.sp),
                                    )),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
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

  Widget interestsList() {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) =>
          previous.interestIndex != current.interestIndex,
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                4,
                (index) => CustomChooseButton(
                    active: index == state.interestIndex,
                    child: index == 0
                        ? Text("ALL",
                            style:
                                TextStyle(fontSize: 15.sp, color: whiteColor))
                        : Icon(
                            [
                              FontAwesomeIcons.car,
                              FontAwesomeIcons.motorcycle,
                              FontAwesomeIcons.bicycle
                            ][index - 1],
                            color: whiteColor,
                            size: 24.r,
                          ),
                    onPressed: () {
                      if (index == 3) {
                        showToast("wait the next update", type: ToastType.info);
                      } else {
                        context.read<LoginCubit>().changeInterestsIndex(index);
                      }
                    })));
      },
    );
  }
}

// This is the Painter class
