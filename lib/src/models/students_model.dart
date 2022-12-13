import 'dart:convert';

import 'package:adf_cli/src/models/address_model.dart';
import 'package:adf_cli/src/models/courses_model.dart';

class StudentsModel {
  StudentsModel({
    required this.name,
    required this.nameCourses,
    required this.courses,
    required this.address,
    this.id,
    this.age,
  });

  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    var nameCoursesList = <String>[];
    var coursesList = <Map<String, dynamic>>[];

    final nameCoursesDynamic = map['nameCourses'] as List<dynamic>?;
    if (nameCoursesDynamic != null) {
      nameCoursesList = List<String>.from(nameCoursesDynamic);
    }

    final coursesDynamic = map['courses'] as List<dynamic>?;
    if (coursesDynamic != null) {
      coursesList = List<Map<String, dynamic>>.from(coursesDynamic);
    }

    return StudentsModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String? ?? '',
      age: map['age'] as int?,
      nameCourses: nameCoursesList,
      courses: coursesList.map(CoursesModel.fromMap).toList(),
      address: AddressModel.fromMap(
        map['address'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  factory StudentsModel.fromJson(String source) =>
      StudentsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<CoursesModel> courses;
  final AddressModel address;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((course) => course.toMap()).toList(),
      'address': address.toMap(),
    };
  }
}
