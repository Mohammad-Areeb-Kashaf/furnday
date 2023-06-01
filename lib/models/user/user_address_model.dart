class UserAddressModel {
  String? firstName;
  String? lastName;
  String? companyName;
  String? streetAddress;
  String? apartmentSuite;
  String? townCityName;
  int? pincode;
  String? state;
  String? email;
  int? phoneNumber;

  UserAddressModel(
      {this.firstName,
      this.lastName,
      this.companyName,
      this.streetAddress,
      this.apartmentSuite,
      this.townCityName,
      this.pincode,
      this.state,
      this.email,
      this.phoneNumber});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    streetAddress = json['streetAddress'];
    apartmentSuite = json['apartmentSuite'];
    townCityName = json['townCityName'];
    pincode = json['pincode'];
    state = json['state'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['companyName'] = companyName;
    data['streetAddress'] = streetAddress;
    data['apartmentSuite'] = apartmentSuite;
    data['townCityName'] = townCityName;
    data['pincode'] = pincode;
    data['state'] = state;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
