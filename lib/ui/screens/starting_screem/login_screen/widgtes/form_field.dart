import 'package:car_e_commerce/constants/theme.dart';
import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: TextFormField(
        controller: controller,
        obscureText: isPass,
        autofillHints: [fillHint],
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: Icon(
            prefix,
          ),
          labelText: title,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
