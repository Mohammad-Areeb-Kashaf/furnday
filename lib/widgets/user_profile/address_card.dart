import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/models/user/user_address_model.dart';
import 'package:furnday/screens/user_profile_screens/address/edit_delivery_address_screen.dart';
import 'package:furnday/widgets/decorated_card.dart';
import 'package:furnday/widgets/heading_section_text.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    super.key,
    this.isShipping = false,
    this.isAddressNull = false,
    required this.userAddress,
  });
  final bool isShipping;
  final UserAddressModel userAddress;
  final bool isAddressNull;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingSectionText(
            headingText:
                widget.isShipping ? "Shipping Address" : "Billing Address",
            isAddress: widget.isAddressNull ? false : true,
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditDeliveryAddressScreen(
                  addressType: widget.isShipping ? "Shipping" : "Billing",
                  userAddress: widget.userAddress,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.isAddressNull
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AutoSizeText("No Address Found"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      EditDeliveryAddressScreen(
                                          isAddressNull: true,
                                          addressType: widget.isShipping
                                              ? "Shipping"
                                              : "Billing",
                                          userAddress: UserAddressModel()))),
                          child: const Text('Add Address'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.userAddress.companyName!.isNotEmpty
                          ? AutoSizeText(
                              widget.userAddress.companyName.toString(),
                              minFontSize: 18,
                              maxFontSize: 20,
                            )
                          : const SizedBox.shrink(),
                      widget.userAddress.companyName!.isNotEmpty
                          ? const SizedBox(
                              height: 4,
                            )
                          : const SizedBox.shrink(),
                      AutoSizeText(
                        "${widget.userAddress.firstName.toString()} ${widget.userAddress.lastName.toString()}",
                        minFontSize: 18,
                        maxFontSize: 20,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AutoSizeText(
                        widget.userAddress.streetAddress.toString(),
                        minFontSize: 18,
                        maxFontSize: 20,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      widget.userAddress.apartmentSuite!.isNotEmpty
                          ? AutoSizeText(
                              widget.userAddress.apartmentSuite.toString(),
                              minFontSize: 18,
                              maxFontSize: 20,
                            )
                          : const SizedBox.shrink(),
                      widget.userAddress.apartmentSuite!.isNotEmpty
                          ? const SizedBox(
                              height: 4,
                            )
                          : const SizedBox.shrink(),
                      AutoSizeText(
                        "${widget.userAddress.townCityName.toString()} ${widget.userAddress.pincode.toString()}",
                        minFontSize: 18,
                        maxFontSize: 20,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AutoSizeText(
                        widget.userAddress.state.toString(),
                        minFontSize: 18,
                        maxFontSize: 20,
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
