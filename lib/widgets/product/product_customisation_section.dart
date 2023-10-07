import 'package:furnday/constants.dart';

class ProductCustomisationSection extends StatefulWidget {
  const ProductCustomisationSection({
    super.key,
    this.customisations,
    required this.onCustomisationChanged,
  });
  final List<String>? customisations;
  final Function? onCustomisationChanged;

  @override
  State<ProductCustomisationSection> createState() =>
      _ProductCustomisationSectionState();
}

class _ProductCustomisationSectionState
    extends State<ProductCustomisationSection> {
  List<bool> checkBoxTileValue = [];

  @override
  Widget build(BuildContext context) {
    for (var _ in widget.customisations!) {
      checkBoxTileValue.add(false);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DecoratedCard(
        child: Column(
          children: [
            const HeadingSectionText(
              headingText: "Customisations",
            ),
            widget.customisations!.isNotEmpty
                ? ListView.builder(
                    physics: kScrollPhysics,
                    shrinkWrap: true,
                    itemCount: widget.customisations!.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        activeColor: kYellowColor,
                        selected: checkBoxTileValue[index],
                        value: checkBoxTileValue[index],
                        onChanged: (value) {
                          setState(() {
                            checkBoxTileValue[index] = value!;
                          });
                          widget.onCustomisationChanged!(value, index);
                        },
                        title: Text(widget.customisations![index]),
                      );
                    })
                : const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('No customisations available for this product'),
                  ),
          ],
        ),
      ),
    );
  }
}
