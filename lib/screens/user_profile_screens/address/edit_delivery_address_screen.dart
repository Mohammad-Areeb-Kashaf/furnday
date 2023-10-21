import 'package:furnday/constants.dart';

class EditDeliveryAddressScreen extends StatefulWidget {
  const EditDeliveryAddressScreen(
      {super.key,
      required this.addressType,
      required this.userAddress,
      this.isAddressNull = false});
  final String addressType;
  final UserAddressModel userAddress;
  final bool isAddressNull;

  @override
  State<EditDeliveryAddressScreen> createState() =>
      _EditDeliveryAddressScreenState();
}

class _EditDeliveryAddressScreenState extends State<EditDeliveryAddressScreen> {
  final userAddressController = Get.find<UserAddressController>();
  String firstName = '',
      lastName = '',
      companyName = '',
      streetAddress = '',
      apartmentSuiteName = '',
      townCityName = '',
      state = '',
      pinCode = '',
      phoneNumber = '',
      emailAddress = '';

  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      companyNameController = TextEditingController(),
      streetAddressController = TextEditingController(),
      apartmentSuiteController = TextEditingController(),
      townCityNameController = TextEditingController(),
      pinCodeController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      emailController = TextEditingController();
  TextEditingController countryRegionNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var stateValue;

  @override
  void initState() {
    super.initState();
    if (widget.isAddressNull == false) {
      firstNameController.text = widget.userAddress.firstName.toString().trim();
      lastNameController.text = widget.userAddress.lastName.toString().trim();
      companyNameController.text =
          widget.userAddress.companyName.toString().trim();
      streetAddressController.text =
          widget.userAddress.streetAddress.toString().trim();
      apartmentSuiteController.text =
          widget.userAddress.apartmentSuite.toString().trim();
      townCityNameController.text =
          widget.userAddress.townCityName.toString().trim();
      pinCodeController.text = widget.userAddress.pincode.toString().trim();
      phoneNumberController.text =
          widget.userAddress.phoneNumber.toString().trim();
      emailController.text = widget.userAddress.email.toString().trim();
      state = widget.userAddress.state.toString().trim();
    }
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: firstNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'First Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: kBorderRadiusCard,
                ),
                border: OutlineInputBorder(
                  borderRadius: kBorderRadiusCard,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'First Name is Required';
                }
                return null;
              },
              onSaved: (value) {
                firstName = value.toString().trim();
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextFormField(
              controller: lastNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'Last Name',
                enabledBorder: OutlineInputBorder(
                  borderRadius: kBorderRadiusCard,
                ),
                border: OutlineInputBorder(
                  borderRadius: kBorderRadiusCard,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Last Name is Required';
                }
                return null;
              },
              onSaved: (value) {
                lastName = value.toString().trim();
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
        controller: companyNameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Company Name (optional)',
          enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
        ),
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          companyName = value.toString().trim();
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
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
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
            controller: streetAddressController,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Street Address',
              hintText: 'House No. and Street Name',
              enabledBorder: OutlineInputBorder(
                borderRadius: kBorderRadiusCard,
              ),
              border: OutlineInputBorder(
                borderRadius: kBorderRadiusCard,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Street Address is Required';
              }
              return null;
            },
            onSaved: (value) {
              streetAddress = value.toString().trim();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: apartmentSuiteController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Apartment, suite, unit, etc. (optional)',
              enabledBorder: OutlineInputBorder(
                borderRadius: kBorderRadiusCard,
              ),
              border: OutlineInputBorder(
                borderRadius: kBorderRadiusCard,
              ),
            ),
            validator: (value) {
              return null;
            },
            onSaved: (value) {
              apartmentSuiteName = value.toString().trim();
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
        controller: townCityNameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Town / City',
          enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Town / City is Required';
          }
          return null;
        },
        onSaved: (value) {
          townCityName = value.toString().trim();
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
        value: state.isNotEmpty ? state : null,
        isExpanded: true,
        borderRadius: kBorderRadiusCard,
        decoration: InputDecoration(
          labelText: "State",
          hoverColor: kHighlightColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value.toString().trim().isEmpty) {
            return "State is required";
          }
          return null;
        },
        onSaved: (value) {
          state = value.toString().trim();
        },
        items: dropDownItems,
        onChanged: (value) {
          state = value.toString().trim();
        },
      ),
    );
  }

  Widget _buildPinCode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: pinCodeController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Pin Code',
          enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Pin Code is Required';
          }
          return null;
        },
        onSaved: (value) {
          pinCode = value.toString().trim();
        },
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Phone (+91)',
          enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Phone is Required';
          } else if (value.length != 10) {
            return 'Phone number should contain 10 numbers';
          }
          return null;
        },
        onSaved: (value) {
          phoneNumber = value.toString().trim();
        },
      ),
    );
  }

  Widget _buildEmailAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email Address',
          enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
          border: OutlineInputBorder(
            borderRadius: kBorderRadiusCard,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email Address is Required';
          } else if (value.isNotEmpty) {
            Pattern pattern =
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?)*$";
            RegExp regex = RegExp(pattern.toString());
            if (!regex.hasMatch(value) || value.isEmpty) {
              return 'Enter a valid email address';
            }
          }
          return null;
        },
        onSaved: (value) {
          emailAddress = value.toString().trim();
        },
      ),
    );
  }

  saveAddress() async {
    if (!_formKey.currentState!.validate()) {
    } else {
      _formKey.currentState!.save();
      try {
        if (widget.addressType == "Shipping") {
          UserAddressModel userAddress = UserAddressModel(
            firstName: firstName,
            lastName: lastName,
            companyName: companyName,
            streetAddress: streetAddress,
            apartmentSuite: apartmentSuiteName,
            townCityName: townCityName,
            pincode: int.parse(pinCode),
            state: state,
            email: emailAddress,
            phoneNumber: int.parse(phoneNumber),
          );
          await userAddressController.setShippingAddress(
              userAddress: userAddress);
          Navigator.pop(context);
        } else {
          UserAddressModel userAddress = UserAddressModel(
            firstName: firstName,
            lastName: lastName,
            companyName: companyName,
            streetAddress: streetAddress,
            apartmentSuite: apartmentSuiteName,
            townCityName: townCityName,
            pincode: int.parse(pinCode),
            state: state,
          );
          await userAddressController.setBillingAddress(
              userAddress: userAddress);
          Navigator.pop(context);
        }
      } catch (e) {
        printError(info: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isAddressNull
                ? 'Add ${widget.addressType} Address'
                : 'Edit ${widget.addressType} Address',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: kScrollPhysics,
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
                    widget.addressType == "Shipping"
                        ? _buildPhoneNumber()
                        : const SizedBox.shrink(),
                    widget.addressType == "Shipping"
                        ? _buildEmailAddress()
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => saveAddress(),
                        child: Text(
                          'Save Address',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
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
