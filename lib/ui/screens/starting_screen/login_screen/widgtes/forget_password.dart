import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constants/theme.dart';
import 'form_field.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      decoration: BoxDecoration(
          gradient: themeGradient,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forget password",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            "Reset mail will be sent to you ",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 28.h,
          ),
          Form(
            key: formKey,
            child: DefaultFormField(
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
          ),
          SizedBox(
            height: 28.h,
          ),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            // state.status == LoginStatus.submittingEmail
            //             ? const CircularProgressIndicator()
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // context.read<LoginCubit>().emailChange(emailController.text);
                    // context.read<LoginCubit>().passwordChange(passController.text);
                    // context
                    //     .read<LoginCubit>()
                    //     .signInWithFirebaseByEmailAndPassword();
                  }
                },
                child: Text(
                  "Send mail",
                  style: TextStyle(fontSize: 20.sp),
                )),
          )
        ],
      ),
    );
  }
}
