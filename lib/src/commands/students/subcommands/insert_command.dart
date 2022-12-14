import 'dart:io';

import 'package:adf_cli/src/models/address_model.dart';
import 'package:adf_cli/src/models/city_model.dart';
import 'package:adf_cli/src/models/phone_model.dart';
import 'package:adf_cli/src/models/student_model.dart';
import 'package:adf_cli/src/repositories/product_repository.dart';
import 'package:adf_cli/src/repositories/students_repository.dart';
import 'package:args/command_runner.dart';

class InsertCommand extends Command<dynamic> {
  InsertCommand(this.studentsRepository) {
    argParser.addOption('file', help: 'Path of the CSV file', abbr: 'f');
  }
  final StudentsRepository studentsRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Insert Students';

  @override
  String get name => 'insert';

  @override
  Future<void> run() async {
    final filePath = argResults?['file'] as String? ?? '';

    if (filePath.isNotEmpty) {
      stdout.writeln('Aguarde...');
      final students = File(filePath).readAsLinesSync();
      stdout.writeln('------------------------------------------');

      for (final student in students) {
        final studentData = student.split(',');
        final coursesList = studentData[2].split('/');

        final coursesFuture = coursesList.map((courseName) async {
          final courseModel = await productRepository.findByName(courseName);
          courseModel.isStudent = true;
          return courseModel;
        }).toList();

        final courses = await Future.wait(coursesFuture);

        final studentModel = StudentModel(
          name: studentData[0],
          nameCourses: coursesList,
          courses: courses,
          address: AddressModel(
            street: studentData[3],
            number: int.parse(studentData[4]),
            zipCode: studentData[5],
            city: CityModel(
              id: 1,
              name: studentData[6],
            ),
            phone: PhoneModel(
              ddd: int.parse(studentData[7]),
              phone: studentData[8],
            ),
          ),
        );

        await studentsRepository.insert(studentModel);
      }

      stdout
        ..writeln('-----------------------------------------------')
        ..writeln('Alunos adicionados com sucesso');
    }
  }
}
