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
    return Container(
      height: 45.r,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(26.r))),
      child: TextFormField(
        controller: controller,
        obscureText: isPass,
        autofillHints: [fillHint],
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: darkGrayColor, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 4),
          // enabledBorder: InputBorder.none,
          border: InputBorder.none,
          fillColor: Colors.white,
          suffixIcon: suffix,
          errorStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
            color: Colors.red[500],
          ),
          prefixIcon: Icon(
            prefix,
            size: 20.r,
          ),
          labelText: title,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
