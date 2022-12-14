import 'dart:convert';

import 'package:adf_cli/src/models/student_model.dart';
import 'package:http/http.dart' as http;

class StudentsRepository {
  Future<List<StudentModel>> findAll() async {
    final studentsResult = await http.get(
      Uri.parse('http://localhost:8080/students'),
    );

    final studentsData = jsonDecode(studentsResult.body) as List<dynamic>?;

    if (studentsData != null) {
      final listStudents = List<Map<String, dynamic>>.from(studentsData);
      return listStudents.map(StudentModel.fromMap).toList();
    }

    return <StudentModel>[];
  }

  Future<StudentModel> findById(int id) async {
    final studentsResult = await http.get(
      Uri.parse('http://localhost:8080/students/$id'),
    );

    final studentsData =
        jsonDecode(studentsResult.body) as Map<String, dynamic>?;

    if (studentsData != null) {
      return StudentModel.fromMap(studentsData);
    }

    throw Exception('Estudante não encontrado');
  }

  Future<void> insert(StudentModel studentsModel) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/students'),
      body: studentsModel.toJson(),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(StudentModel studentsModel) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/students/${studentsModel.id}'),
      body: studentsModel.toJson(),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:8080/students/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
