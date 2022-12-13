import 'dart:convert';

class PhoneModel {
  PhoneModel({
    required this.ddd,
    required this.phone,
  });

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      ddd: map['ddd'] as int? ?? 0,
      phone: map['phone'] as String? ?? '',
    );
  }

  factory PhoneModel.fromJson(String source) =>
      PhoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final int ddd;
  final String phone;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ddd': ddd,
      'phone': phone,
    };
  }
}
