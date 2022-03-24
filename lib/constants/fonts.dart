import 'package:car_e_commerce/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 32.sp, fontWeight: FontWeight.bold, color: darkGrayColor),
  headline2: GoogleFonts.poppins(
      fontSize: 24.sp, fontWeight: FontWeight.w500, color: darkGrayColor),
  headline3: GoogleFonts.poppins(
      fontSize: 14.sp, fontWeight: FontWeight.w700, color: darkGrayColor),
  headline4: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w700),
  subtitle1:
      GoogleFonts.alegreyaSans(fontSize: 16.sp, fontWeight: FontWeight.w500),
  button:
      GoogleFonts.alegreyaSans(fontSize: 16.sp, fontWeight: FontWeight.w500),
  caption: GoogleFonts.alegreyaSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: darkGrayColor),
  overline: GoogleFonts.alegreyaSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
