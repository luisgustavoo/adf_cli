import 'dart:convert';

class CoursesModel {
  CoursesModel({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  factory CoursesModel.fromMap(Map<String, dynamic> map) {
    return CoursesModel(
      id: map['id'] as int? ?? 0,
      name: map['name'] as String? ?? '',
      isStudent: map['isStudent'] as bool? ?? false,
    );
  }

  factory CoursesModel.fromJson(String source) =>
      CoursesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;
  final String name;
  bool isStudent;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  String toJson() => json.encode(toMap());
}
