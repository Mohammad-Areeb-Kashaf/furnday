import 'package:furnday/constants.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.validate,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final Function validate;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      style: const TextStyle(fontSize: 24, color: Colors.black),
      cursorHeight: 24,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: kBorderRadiusCard,
          borderSide: const BorderSide(color: kYellowColor),
        ),
        border: OutlineInputBorder(
          borderRadius: kBorderRadiusCard,
          borderSide: const BorderSide(color: kYellowColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: kBorderRadiusCard,
          borderSide: const BorderSide(color: Colors.black),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 24, color: Colors.black),
        floatingLabelStyle: TextStyle(
            fontSize: 24,
            color: focusNode.hasPrimaryFocus ? kYellowColor : null),
        focusColor: kYellowColor,
        errorMaxLines: 5,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      validator: (value) => validate(value),
    );
  }
}
