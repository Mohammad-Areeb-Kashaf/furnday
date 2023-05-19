import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:intl/intl.dart';

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({super.key});

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  NumberFormat formatter = NumberFormat('00');
  int _qty = 1;
  final int _tagIndex = 0;

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
              }
            },
            child: Icon(
              Icons.remove,
              size: 32,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          AutoSizeText(
            formatter.format(_qty),
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            maxFontSize: 18,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _qty++;
              });
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
