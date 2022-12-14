import 'dart:convert';

import 'package:adf_cli/src/models/courses_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<CoursesModel> findByName(String name) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body) as List<dynamic>?;

    if (responseData == null) {
      throw Exception('Produto não encontrado');
    }

    return CoursesModel.fromMap(
      List<Map<String, dynamic>>.from(responseData).first,
    );
  }
}
