import 'package:flutter/material.dart';

Widget calcButton(String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: buttonText == '0' ? 175 : 80,
    height: buttonText == '=' ? 150 : 70,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
