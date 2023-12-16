import 'package:furnday/constants.dart';

class ProductCustomisationSection extends StatefulWidget {
  const ProductCustomisationSection({
    super.key,
    this.customisations,
    this.onValueChanged,
  });
  final String? customisations;
  final Function(String)? onValueChanged;

  @override
  State<ProductCustomisationSection> createState() =>
      _ProductCustomisationSectionState();
}

class _ProductCustomisationSectionState
    extends State<ProductCustomisationSection> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DecoratedCard(
        child: Column(
          children: [
            const HeadingSectionText(
              headingText: "Customisations",
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLines: 5,
                onChanged: widget.onValueChanged,
                decoration: const InputDecoration(
                  labelText: "Customisations",
                  labelStyle: TextStyle(color: Colors.black),
                  hintText:
                      "Describe the customisations you want to make to this product like the color, size, material, etc",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusColor: kYellowColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
