
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {super.key,
      required this.text,
      required this.onTap,
      required this.textColor});

  final void Function() onTap;
  final String text;
  final String textColor;

  @override
  Widget build(BuildContext context) {
    Color getTextColor(String color) {
      if (color.toLowerCase() == 'white') {
        return Colors.white;
      }
      if (color.toLowerCase() == 'black') {
        return Colors.black;
      }

      return Colors.black;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 70,
        ),
        backgroundColor: const Color.fromARGB(255, 241, 143, 1),
        foregroundColor: getTextColor(textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 10,
        shadowColor: const Color.fromARGB(255, 123, 240, 168),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
    );
  }
}
