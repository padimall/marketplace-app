import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PadiMallTextTheme {
  static TextStyle sz20weigth700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz32weigth700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz20weigth700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87);
  }

  static TextStyle sz18weigth700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz16weigth700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz16weigth700Green(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).primaryColor);
  }

  static TextStyle sz16weigth700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87);
  }

  static TextStyle sz14weigth700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87);
  }

  static TextStyle sz14weigth700Green(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor);
  }

  static TextStyle sz14weigth700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz14weigth600(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87);
  }

  static TextStyle sz14weigth500(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87);
  }

  static TextStyle sz13weigth500Green(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 13, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor);
  }

  static TextStyle sz14weigth500Grey(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey);
  }

  static TextStyle sz13weigth500(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87);
  }
}
