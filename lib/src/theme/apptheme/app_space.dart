import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class GAppSp {
  static double xs = 4;
  static double s = 6;
  static double md = 8;
  static double no = 10;
  static double lg = 12;
  static double xl = 16;
  static double xxl = 32;
}

class GSizeH extends StatelessWidget {
  GSizeH(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class GSizeW extends StatelessWidget {
  GSizeW(this.width, {super.key});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
