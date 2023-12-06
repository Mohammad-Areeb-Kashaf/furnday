import 'package:furnday/constants.dart';

class ProductCustomisationSection extends StatefulWidget {
  const ProductCustomisationSection({
    super.key,
    this.customisations,
  });
  final List<String>? customisations;

  @override
  State<ProductCustomisationSection> createState() =>
      _ProductCustomisationSectionState();
}

class _ProductCustomisationSectionState
    extends State<ProductCustomisationSection> {
  List<bool> checkBoxTileValue = [];

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: DecoratedCard(
        child: Column(
          children: [
            HeadingSectionText(
              headingText: "Customisations",
            ),
          ],
        ),
      ),
    );
  }
}
