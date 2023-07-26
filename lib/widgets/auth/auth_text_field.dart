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
  bool obscureText = false;
  final String labelText;
  final Function validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 24),
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
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 24),
      ),
      validator: (value) => validate(value),
    );
  }
}
