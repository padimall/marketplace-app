import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PadiMallTextTheme {
  static TextStyle sz20weight700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz32weight700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz20weight700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87);
  }

  static TextStyle sz18weight700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz16weight700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz16weight700Green(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).primaryColor);
  }

  static TextStyle sz16weight700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87);
  }

  static TextStyle sz14weight700(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87);
  }

  static TextStyle sz14weight700Green(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor);
  }

  static TextStyle sz14weight700White(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
  }

  static TextStyle sz14weight600(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87);
  }

  static TextStyle sz14weight500Grey(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey);
  }

  static TextStyle sz14weight600Red(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor);
  }

  static TextStyle sz14weight500(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87);
  }

  static TextStyle sz13weight600(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87);
  }

  static TextStyle sz13weight500Green(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 13, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor);
  }

  static TextStyle sz13weight500(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87);
  }

  static TextStyle sz12weight500(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87);
  }

  static TextStyle sz12weight500Grey(BuildContext context) {
    return GoogleFonts.poppins().copyWith(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey);
  }
}
