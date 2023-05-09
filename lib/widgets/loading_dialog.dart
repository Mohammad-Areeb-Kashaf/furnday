import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furnday/constants.dart';

loadDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const Center(
      child: SpinKitFoldingCube(
        color: yellowColor,
      ),
    ),
  );
}
