import 'package:furnday/constants.dart';

class CartProductCustomisationSection extends StatefulWidget {
  const CartProductCustomisationSection(
      {super.key, this.customisations, this.onCustomisationChanged});

  final List<String>? customisations;
  final Function? onCustomisationChanged;

  @override
  State<CartProductCustomisationSection> createState() =>
      _CartProductCustomisationSectionState();
}

class _CartProductCustomisationSectionState
    extends State<CartProductCustomisationSection> {
  List<bool> checkBoxTileValue = [];
  @override
  Widget build(BuildContext context) {
    for (var _ in widget.customisations!) {
      checkBoxTileValue.add(true);
    }
    return widget.customisations!.isNotEmpty
        ? ListView.builder(
            physics: kScrollPhysics,
            shrinkWrap: true,
            itemCount: widget.customisations!.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                activeColor: kYellowColor,
                selected: checkBoxTileValue[index],
                enabled: false,
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
          );
  }
}
