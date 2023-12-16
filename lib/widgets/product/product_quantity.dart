import 'package:furnday/constants.dart';

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({
    super.key,
    required this.valueChanged,
    required this.qty,
  });

  final Function valueChanged;
  final int qty;

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  NumberFormat formatter = NumberFormat('00');
  int _qty = 1;
  var indexCartItem = 0;

  @override
  void initState() {
    super.initState();
    _qty = widget.qty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColorDark,
        ),
        borderRadius: kBorderRadiusCard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (_qty > 1) {
                setState(() {
                  _qty--;
                });
                widget.valueChanged(
                  _qty,
                );
              }
            },
            child: Icon(
              Icons.remove,
              size: 32,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          Text(
            formatter.format(_qty),
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _qty++;
              });
              widget.valueChanged(
                _qty,
              );
            },
            child: Icon(
              Icons.add,
              size: 32,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
