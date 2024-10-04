import 'package:flutter/material.dart';

class Styles {
  static String fontFamily = 'Urbanist';
  static TextStyle style12(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style14(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style14SemiBold(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
      color: const Color(0xff8391A1),
    );
  }

  static TextStyle style15(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 15),
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
      color: Colors.white,
    );
  }

  static TextStyle style15Medium(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 15),
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      color: const Color(0xff8391A1),
    );
  }

  static TextStyle style16(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style16Medium(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      color: const Color(0xff838BA1),
    );
  }

  static TextStyle style18Med(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w500,
      color: const Color(0xffF9E95F),
      fontFamily: fontFamily,
    );
  }

  static TextStyle style18(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w600,
      color: const Color(0xffE46AD9),
      fontFamily: fontFamily,
    );
  }

  static TextStyle style20Light(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontWeight: FontWeight.w300,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style20(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style23(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 23),
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style26(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 26),
      fontWeight: FontWeight.w800,
      color: Colors.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style30Bold(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style35(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 35),
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style43SemiBold(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 43),
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style48(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 48),
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
    );
  }

  static TextStyle style50(BuildContext context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 50),
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: fontFamily,
    );
  }
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = MediaQuery.sizeOf(context).width / 400;
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}
