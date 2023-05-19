import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class HeadingSectionText extends StatelessWidget {
  HeadingSectionText(
      {super.key,
      required this.headingText,
      this.isAddress = false,
      this.onPressed});
  final bool isAddress;
  var onPressed;

  final String headingText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 246, 195, 60),
        borderRadius: BorderRadius.only(
          topLeft: kRadius,
          topRight: kRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                headingText,
                style: const TextStyle(fontWeight: FontWeight.bold),
                minFontSize: 18,
                maxFontSize: 26,
              ),
            ),
          ),
          isAddress
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: TextButton(
                    onPressed: isAddress ? onPressed : null,
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
