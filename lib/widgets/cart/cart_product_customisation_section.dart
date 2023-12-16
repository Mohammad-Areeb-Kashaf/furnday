import 'package:furnday/constants.dart';

class CartProductCustomisationSection extends StatefulWidget {
  const CartProductCustomisationSection(
      {super.key, this.customisations});

  final String? customisations;

  @override
  State<CartProductCustomisationSection> createState() =>
      _CartProductCustomisationSectionState();
}

class _CartProductCustomisationSectionState
    extends State<CartProductCustomisationSection> {
  List<bool> checkBoxTileValue = [];
  @override
  Widget build(BuildContext context) {
    return widget.customisations != null 
        ? RichText(
            text: TextSpan(
                text: "Customisations:",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: widget.customisations,
                      style: const TextStyle(color: Colors.black)),
                ]),
          )
        : const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('No customisations entered by you'),
          );
  }
}
