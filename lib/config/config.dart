import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyColors {
  static Color primary = const Color(0xff171C3C);
  static Color secondary = const Color(0xffD9D9D9);
  final Color third = const Color.fromARGB(255, 217, 217, 217);
  final Color fourth = const Color.fromARGB(255, 212, 245, 252);
  static Color fifth = const Color(0xff131522);

  
}

class MyFonts {
  static TextStyle primary = TextStyle(
    color: MyColors.primary,
    fontSize: 16.sp,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.bold,
    letterSpacing: 0.20,
  );

  final TextStyle primary300 = TextStyle(
      fontSize: 16.sp, fontFamily: 'Urbanist', fontWeight: FontWeight.w300);

  final TextStyle secondary = TextStyle(
      color: const Color.fromARGB(255, 80, 101, 252),
      fontSize: 16.sp,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700);

  final TextStyle third = TextStyle(
      fontSize: 28.sp, fontFamily: 'Urbanist', fontWeight: FontWeight.w700);
}
