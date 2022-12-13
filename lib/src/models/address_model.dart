import 'dart:convert';

import 'package:adf_cli/src/models/city_model.dart';
import 'package:adf_cli/src/models/phone_model.dart';

class AddressModel {
  AddressModel({
    required this.street,
    required this.number,
    required this.zipCode,
    required this.city,
    required this.phone,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      street: map['street'] as String? ?? '',
      number: map['number'] as int? ?? 0,
      zipCode: map['zipCode'] as String? ?? '',
      city: CityModel.fromMap(
        map['city'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
      phone: PhoneModel.fromMap(
        map['phone'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String street;
  final int number;
  final String zipCode;
  final CityModel city;
  final PhoneModel phone;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }
}
