import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenConfig {
  static double? gridHeight, gridWidth;
  static TextStyle? errortxt,
      label,
      blackH2,
      blackH3,
      blackH6,
      blackH6Bold,
      whiteH6,
      redBold,
      greyH6,
      greyH3,
      greyH2,
      greyH1,
      blackH1,
      blackH2Bold;
  static UnderlineInputBorder? enabledborderStyle;
  static OutlineInputBorder? borderStyle, whiteOutLinedBorder;
  static Color appBar = const Color(0xFFe80000),
      background = Colors.white,
      onPrimary = const Color(0xFFACB4B4);

  read(BuildContext context) {
    gridHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewPadding.top -
            MediaQuery.of(context).viewPadding.bottom) /
        100;
    gridWidth = MediaQuery.of(context).size.width / 100;
    errortxt = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: gridHeight! * 2,
        color: Colors.red);
    redBold = TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: gridHeight! * 2.4,
        color: Colors.red);
    label = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: gridHeight! * 2.7,
        color: Colors.white);
    blackH2 = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: gridHeight! * 2.7,
        color: Colors.black);
    blackH3 = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: gridHeight! * 2.1,
        color: Colors.black);
    blackH2Bold = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: gridHeight! * 2.5,
        color: Colors.black);
    blackH6Bold = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: gridHeight! * 2,
        color: Colors.black);
    blackH6 = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: gridHeight! * 2,
        color: Colors.black);
    blackH1 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: gridHeight! * 3.5,
      color: Colors.black, //Colors.cyan[800],
    );
    greyH1 = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: gridHeight! * 3,
        color: Colors.grey);
    greyH2 = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: gridHeight! * 2.5,
        color: Colors.grey);
    greyH3 = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: gridHeight! * 2.2,
        color: Colors.grey);

    greyH6 = TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: gridHeight! * 2,
        fontStyle: FontStyle.italic,
        color: Colors.grey);

    whiteH6 = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: gridHeight! * 2,
        color: Colors.white);

    borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 3, color: Colors.black),
    );
    whiteOutLinedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 3, color: Colors.white),
    );
    enabledborderStyle = const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    );
  }
}
