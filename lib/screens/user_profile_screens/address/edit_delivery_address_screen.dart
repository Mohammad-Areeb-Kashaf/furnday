import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/internet_checker.dart';

class EditDeliveryAddressScreen extends StatefulWidget {
  const EditDeliveryAddressScreen({super.key, required this.addressType});
  final String addressType;

  @override
  State<EditDeliveryAddressScreen> createState() =>
      _EditDeliveryAddressScreenState();
}

class _EditDeliveryAddressScreenState extends State<EditDeliveryAddressScreen> {
  String firstName = '',
      lastName = '',
      companyName = '',
      houseStreetName = '',
      apartmentSuiteUnit = '',
      townCity = '',
      state = '',
      pinCode = '',
      phoneNo = '',
      emailAddress = '';

  TextEditingController countryRegionNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'First Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCard,
                ),
                border: OutlineInputBorder(
                  borderRadius: borderRadiusCard,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'First Name is Required';
                }
                return null;
              },
              onSaved: (value) {
                firstName = value.toString();
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Last Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadiusCard,
                ),
                border: OutlineInputBorder(
                  borderRadius: borderRadiusCard,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Last Name is Required';
                }
                return null;
              },
              onSaved: (value) {
                lastName = value.toString();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Company Name (optional)',
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          companyName = value.toString();
        },
      ),
    );
  }

  Widget _buildCountryName() {
    countryRegionNameController.text = "India";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: countryRegionNameController,
        enabled: false,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Country / Region',
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Country / Region is Required';
          }
          return null;
        },
        onSaved: (value) {},
      ),
    );
  }

  Widget _buildStreetAddress() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Street Address',
              hintText: 'House No. and Street Name',
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadiusCard,
              ),
              border: OutlineInputBorder(
                borderRadius: borderRadiusCard,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Street Address is Required';
              }
              return null;
            },
            onSaved: (value) {
              houseStreetName = value.toString();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Apartment, suite, unit, etc. (optional)',
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadiusCard,
              ),
              border: OutlineInputBorder(
                borderRadius: borderRadiusCard,
              ),
            ),
            validator: (value) {
              return null;
            },
            onSaved: (value) {
              apartmentSuiteUnit = value.toString();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTownCity() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Town / City',
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Town / City is Required';
          }
          return null;
        },
        onSaved: (value) {
          townCity = value.toString();
        },
      ),
    );
  }

  Widget _buildState() {
    final states = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttarakhand",
      "Uttar Pradesh",
      "West Bengal",
      "Andaman and Nicobar Islands",
      "Chandigarh",
      "Dadra and Nagar Haveli and Daman & Diu",
      "Delhi",
      "Jammu and Kashmir",
      "Ladakh",
      "Lakshadweep",
      "Puducherry",
    ];

    late List<DropdownMenuItem> dropDownItems = [];

    for (var i = 0; i < states.length; i++) {
      dropDownItems.add(
        DropdownMenuItem(
          value: states[i],
          child: Text(states[i]),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField(
        isExpanded: true,
        borderRadius: borderRadiusCard,
        decoration: InputDecoration(
          labelText: "State",
          hoverColor: highlightColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value.toString().isEmpty) {
            return "State is required";
          }
          return null;
        },
        onSaved: (value) {
          state = value.toString();
        },
        items: dropDownItems,
        onChanged: (value) {
          state = value.toString();
        },
      ),
    );
  }

  Widget _buildPinCode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Pin Code',
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Pin Code is Required';
          }
          return null;
        },
        onSaved: (value) {
          pinCode = value.toString();
        },
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Phone',
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Phone is Required';
          }
          return null;
        },
        onSaved: (value) {
          phoneNo = value.toString();
        },
      ),
    );
  }

  Widget _buildEmailAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email Address',
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email Address is Required';
          }
          return null;
        },
        onSaved: (value) {
          emailAddress = value.toString();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit ${widget.addressType} Address',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildName(),
                    _buildCompanyName(),
                    _buildCountryName(),
                    _buildStreetAddress(),
                    _buildTownCity(),
                    _buildState(),
                    _buildPinCode(),
                    widget.addressType == "Billing"
                        ? _buildPhoneNumber()
                        : const SizedBox.shrink(),
                    widget.addressType == "Billing"
                        ? _buildEmailAddress()
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            _formKey.currentState!.save();
                          }
                        },
                        child: AutoSizeText(
                          'Save Address',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          maxFontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
