import 'package:car_e_commerce/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DefaultFormField extends StatelessWidget {
  DefaultFormField(
      {required this.controller,
      required this.fillHint,
      required this.title,
      required this.prefix,
      this.isPass = false,
      this.validator,
      this.keyboardType,
      this.suffix,
      Key? key})
      : super(key: key);

  TextEditingController controller;
  String fillHint;
  String title;
  IconData prefix;
  bool isPass = false;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            )),
        TextFormField(
          controller: controller,
          obscureText: isPass,
          autofillHints: [fillHint],
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(color: darkGrayColor, fontSize: 14.sp),
          decoration: InputDecoration(
            // enabledBorder: InputBorder.none,
            border: InputBorder.none,
            // contentPadding: EdgeInsets.symmetric(vertical: 10),
            fillColor: Colors.white,
            suffixIcon: suffix,
            alignLabelWithHint: true,
            errorStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w300,
              color: Colors.red[500],
            ),
            prefixIcon: Icon(
              prefix,
              size: 20.r,
            ),

            hintText: fillHint,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: Colors.grey[500],
            ),
          ),
        ),
      ],
    );
  }
}
