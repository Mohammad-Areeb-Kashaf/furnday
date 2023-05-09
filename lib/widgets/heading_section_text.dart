import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class HeadingSectionText extends StatelessWidget {
  const HeadingSectionText({super.key, required this.headingText});

  final String headingText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 246, 195, 60),
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
            headingText,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxFontSize: 26,
          ),
        ),
      ),
    );
  }
}
