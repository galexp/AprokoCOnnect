import 'package:flutter/material.dart';

Container profileImage(String url) {
  return Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(image: NetworkImage(url))),
  );
}

Text textInfo(String text, FontWeight fontWeight, Color color) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontFamily: "Poppins",
        letterSpacing: 1.5,
        fontWeight: fontWeight),
  );
}
