import 'dart:convert';

class CityModel {
  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as int? ?? 0,
      name: map['name'] as String? ?? '',
    );
  }

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;
  final String name;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }
}
