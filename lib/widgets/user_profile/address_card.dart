import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:furnday/screens/user_profile_screens/address/edit_delivery_address_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/heading_section_text.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, this.isShipping = false});
  final bool isShipping;

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingSectionText(
            headingText: isShipping ? "Shipping Address" : "Billing Address",
            isAddress: true,
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditDeliveryAddressScreen(
                    addressType: isShipping ? "Shipping" : "Billing"),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const AutoSizeText(
            "Company Name",
            minFontSize: 18,
            maxFontSize: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          const AutoSizeText(
            "FirstName LastName",
            minFontSize: 18,
            maxFontSize: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          const AutoSizeText(
            "Street Address",
            minFontSize: 18,
            maxFontSize: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          const AutoSizeText(
            "Apartment, suite, unit, etc.",
            minFontSize: 18,
            maxFontSize: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          const AutoSizeText(
            "Town/City Pincode",
            minFontSize: 18,
            maxFontSize: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          const AutoSizeText(
            "State",
            minFontSize: 18,
            maxFontSize: 20,
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
