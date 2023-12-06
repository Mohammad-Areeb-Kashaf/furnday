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
    return widget.customisations!.isNotEmpty
        ? RichText(
            text: TextSpan(
                text: "Customisations:",
                children: [TextSpan(text: widget.customisations)]),
          )
        : const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('No customisations entered by you'),
          );
  }
}
