import 'dart:io';

import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:furnday/constants.dart';

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
  final GMAIL_SCHEMA = 'com.google.android.gm';

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
                        if (Platform.isIOS) {
                          final bool canSend =
                              await FlutterMailer.canSendMail();
                          if (!canSend) {
                            const GetSnackBar snackbar = GetSnackBar(
                                titleText: Text('no Email App Available'));
                            Get.showSnackbar(snackbar);
                            return;
                          } else {
                            try {
                              final MailOptions mailOptions = MailOptions(
                                subject: "Hire a Carpenter",
                                recipients: ['areebkashaf7666@gmail.com'],
                                body:
                                    "Name: $name\nPhone Number: $phoneNumber\nAddress: $address\nZip/Postal Code: $postalCode\nCountry:$country\nHiring For:$hireFor",
                                isHTML: true,
                              );
                              final response =
                                  await FlutterMailer.send(mailOptions);
                              switch (response) {
                                case MailerResponse.saved:
                                  Get.showSnackbar(const GetSnackBar(
                                    message: "Mail was saved to draft",
                                  ));
                                  break;
                                case MailerResponse.sent:
                                  Get.showSnackbar(const GetSnackBar(
                                    message:
                                        "Mail was sent, we will contact you",
                                  ));
                                  break;
                                case MailerResponse.cancelled:
                                  Get.showSnackbar(const GetSnackBar(
                                    title: "Error",
                                    message: "Mail was cancelled",
                                  ));
                                  break;
                                case MailerResponse.android:
                                  Get.showSnackbar(const GetSnackBar(
                                    message:
                                        "Mail was sent, we will contact you",
                                  ));
                                  break;
                                default:
                                  Get.showSnackbar(const GetSnackBar(
                                    title: "Error",
                                    message: "Something went wrong",
                                  ));
                                  break;
                              }
                            } catch (e) {
                              Get.showSnackbar(GetSnackBar(
                                title: "Error",
                                message: e.toString(),
                                duration: const Duration(seconds: 3),
                              ));
                            }
                          }
                        } else {
                          final bool gmailinstalled =
                              await FlutterMailer.isAppInstalled(GMAIL_SCHEMA);

                          if (gmailinstalled) {
                            try {
                              final MailOptions mailOptions = MailOptions(
                                subject: "Hire a Carpenter",
                                recipients: ['areebkashaf7666@gmail.com'],
                                body:
                                    "Name: $name\nPhone Number: $phoneNumber\nAddress: $address\nZip/Postal Code: $postalCode\nCountry:$country\nHiring For:$hireFor",
                                isHTML: true,
                              );
                              final response =
                                  await FlutterMailer.send(mailOptions);
                              switch (response) {
                                case MailerResponse.saved:
                                  printInfo(info: "Mail was saved to draft");
                                  Get.showSnackbar(const GetSnackBar(
                                    message: "Mail was saved to draft",
                                  ));
                                  break;
                                case MailerResponse.sent:printInfo(info: "Mail was sent, we will contact you");
                                  Get.showSnackbar(const GetSnackBar(
                                    message:
                                        "Mail was sent, we will contact you",
                                  ));
                                  break;
                                case MailerResponse.cancelled:printInfo(info: "Mail was cancelled");
                                  Get.showSnackbar(const GetSnackBar(
                                    title: "Error",
                                    message: "Mail was cancelled",
                                  ));
                                  break;
                                case MailerResponse.android:printInfo(info: "Mail was sent, we will contact you");
                                  Get.showSnackbar(const GetSnackBar(
                                    message:
                                        "Mail was sent, we will contact you",
                                  ));
                                  break;
                                default:printInfo(info: "Mail was saved to draft");
                                  Get.showSnackbar(const GetSnackBar(
                                    title: "Error",
                                    message: "Something went wrong",
                                  ));
                                  break;
                              }
                            } catch (e) {
                              Get.showSnackbar(GetSnackBar(
                                title: "Error",
                                message: e.toString(),
                                duration: const Duration(seconds: 3),
                              ));
                            }
                          }
                        }
                      }
                    },
                    child: AutoSizeText(
                      'Submit',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      maxFontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
