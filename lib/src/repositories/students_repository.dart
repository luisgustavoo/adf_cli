import 'dart:convert';

import 'package:adf_cli/src/models/students_model.dart';
import 'package:http/http.dart' as http;

class StudentsRepository {
  Future<List<StudentsModel>> findAll() async {
    final studentsResult = await http.get(
      Uri.parse('http://localhost:8080/students'),
    );

    final studentsData = jsonDecode(studentsResult.body) as List<dynamic>?;

    if (studentsData != null) {
      final listStudents = List<Map<String, dynamic>>.from(studentsData);
      return listStudents.map(StudentsModel.fromMap).toList();
    }

    return <StudentsModel>[];
  }

  Future<StudentsModel> findById(int id) async {
    final studentsResult = await http.get(
      Uri.parse('http://localhost:8080/students/$id'),
    );

    final studentsData =
        jsonDecode(studentsResult.body) as Map<String, dynamic>?;

    if (studentsData != null) {
      return StudentsModel.fromMap(studentsData);
    }

    throw Exception('Estudante não encontrado');
  }

  Future<void> insert(StudentsModel studentsModel) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/students'),
      body: studentsModel.toJson(),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(StudentsModel studentsModel) async {
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
