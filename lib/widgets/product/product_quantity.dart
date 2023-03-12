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
  int _tagIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColorDark,
          ),
          borderRadius: borderRadiusCard,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
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
            Text(
              formatter.format(_qty),
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            InkWell(
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
      ),
    );
  }
}
