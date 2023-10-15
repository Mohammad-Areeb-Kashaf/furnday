import 'package:furnday/constants.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class HireACarpenterScreen extends StatefulWidget {
  const HireACarpenterScreen({super.key});

  @override
  State<HireACarpenterScreen> createState() => _HireACarpenterScreenState();
}

class _HireACarpenterScreenState extends State<HireACarpenterScreen> {
  String name = '';
  String phoneNumber = '';
  String address = '';
  String postalCode = '';
  String country = '';
  String hireFor = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          name = value.toString().trim();
        });
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(labelText: 'Phone Number'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phone Number is Required';
        } else if (value.length < 10) {
          return 'Phone Number should be 10 digit number';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          phoneNumber = value.toString().trim();
        });
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      decoration: const InputDecoration(labelText: 'Address'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Address is Required';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          address = value.toString().trim();
        });
      },
    );
  }

  Widget _buildPostalCode() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Zip / Postal Code'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Zip / Postal Code is Required';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          postalCode = value.toString().trim();
        });
      },
    );
  }

  Widget _buildCountry() {
    var countryItems = [
      const DropdownMenuItem(value: 'India', child: AutoSizeText('India')),
    ];
    return DropdownButtonFormField(
      hint: const AutoSizeText('Country'),
      items: countryItems,
      validator: (value) {
        if (value == null) {
          return "Country is Required";
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          country = value.toString().trim();
        });
      },
      onSaved: (value) {
        setState(() {
          country = value.toString().trim();
        });
      },
    );
  }

  Widget _buildHireFor() {
    var hireForItems = [
      const DropdownMenuItem(
        value: 'New Built',
        child: AutoSizeText('New Built'),
      ),
      const DropdownMenuItem(
        value: 'Repair',
        child: AutoSizeText('Repair'),
      ),
      const DropdownMenuItem(
        value: 'Removal/Uninstallation',
        child: AutoSizeText('Removal/Uninstallation'),
      ),
      const DropdownMenuItem(
        value: 'Assemble',
        child: AutoSizeText('Assemble'),
      ),
      const DropdownMenuItem(
        value: 'Consultation',
        child: AutoSizeText('Consultation'),
      ),
    ];
    return DropdownButtonFormField(
      hint: const AutoSizeText('Hiring For'),
      items: hireForItems,
      validator: (value) {
        if (value == null) {
          return "Hiring For is Required";
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          hireFor = value.toString().trim();
        });
      },
      onSaved: (value) {
        setState(() {
          hireFor = value.toString().trim();
        });
      },
    );
  }

  sendMail(
      {required String name,
      required String phoneNumber,
      required String address,
      required String postalCode,
      required String country,
      required String hiringFor}) async {
    try {
      var message = Message();
      message.subject = "Hire Carpenter";
      message.text =
          "Name: $name\nPhone Number: $phoneNumber\nEmail: ${FirebaseAuth.instance.currentUser!.email}\nAddress: $address\nPostal Code: $postalCode\nCountry: $country\nHiring for: $hireFor";
      message.from = const Address("areebkashaf7666@gmail.com");
      message.recipients.add("info@furnday.com");
      var smtpServer = gmail("areebkashaf7666@gmail.com", "nxqhqeyfdjfukiuq");
      await send(message, smtpServer);

      Get.showSnackbar(const GetSnackBar(
        message: "Email has been sent successfully",
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      printError(info: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: myAppBar(context),
        body: SingleChildScrollView(
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
                  _buildPhoneNumber(),
                  _buildAddress(),
                  _buildPostalCode(),
                  _buildCountry(),
                  _buildHireFor(),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await sendMail(
                            name: name,
                            phoneNumber: phoneNumber,
                            address: address,
                            postalCode: postalCode,
                            country: country,
                            hiringFor: hireFor);
                      }
                    },
                    child: AutoSizeText(
                      'Submit',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      maxFontSize: 16,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
