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
      },
      onSaved: (value) {
        _address = value.toString();
      },
    );
  }

  Widget _buildPostalCode() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Postal Code'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Postal Code is Required';
        }
      },
      onSaved: (value) {
        _postalCode = value.toString();
      },
    );
  }

  Widget _buildCountry() {
    var countryItems = [
      const DropdownMenuItem(value: 'India', child: Text('India')),
      const DropdownMenuItem(value: 'Afghanistan', child: Text('Afghanistan'))
    ];
    return DropdownButtonFormField(
      hint: const Text('Country'),
      items: countryItems,
      validator: (value) {
        if (value == null) {
          return "Country is Required";
        }
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
        child: Text('New Built'),
      ),
      const DropdownMenuItem(
        value: 'Repair',
        child: Text('Repair'),
      ),
      const DropdownMenuItem(
        value: 'Removal/Uninstallation',
        child: Text('Removal/Uninstallation'),
      ),
      const DropdownMenuItem(
        value: 'Assemble',
        child: Text('Assemble'),
      ),
      const DropdownMenuItem(
        value: 'Consultation',
        child: Text('Consultation'),
      ),
    ];
    return DropdownButtonFormField(
      hint: const Text('Hiring For'),
      items: hireForItems,
      validator: (value) {
        if (value == null) {
          return "Hiring For is Required";
        }
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
    print(_name);
    return InternetChecker(
      child: Scaffold(
        appBar: myAppBar(context),
        body: SingleChildScrollView(
          physics: scrollPhysics,
          child: Container(
            margin: const EdgeInsets.all(24),
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
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
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
