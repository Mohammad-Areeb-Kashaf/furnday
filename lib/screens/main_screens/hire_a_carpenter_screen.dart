import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/widgets/internet_checker.dart';
import 'package:furnday/widgets/my_appbar.dart';

class HireACarpenterScreen extends StatefulWidget {
  const HireACarpenterScreen({super.key});

  @override
  State<HireACarpenterScreen> createState() => _HireACarpenterScreenState();
}

class _HireACarpenterScreenState extends State<HireACarpenterScreen> {
  String _name = '';
  String _phoneNumber = '';
  String _address = '';
  String _postalCode = '';
  String _country = '';
  String _hireFor = '';

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
        _name = value.toString();
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
        }
        return null;
      },
      onSaved: (value) {
        _phoneNumber = value.toString();
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
        _address = value.toString();
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
        _postalCode = value.toString();
      },
    );
  }

  Widget _buildCountry() {
    var countryItems = [
      const DropdownMenuItem(value: 'India', child: AutoSizeText('India')),
      const DropdownMenuItem(
          value: 'Afghanistan', child: AutoSizeText('Afghanistan'))
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
        _country = value.toString();
      },
      onSaved: (value) {
        _country = value.toString();
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
        _hireFor = value.toString();
      },
      onSaved: (value) {
        _hireFor = value.toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: myAppBar(context),
        body: SingleChildScrollView(
          physics: scrollPhysics,
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
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        _formKey.currentState!.save();
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
