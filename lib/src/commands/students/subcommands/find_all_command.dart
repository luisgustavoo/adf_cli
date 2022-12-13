import 'dart:io';

import 'package:adf_cli/src/repositories/students_repository.dart';
import 'package:args/command_runner.dart';

class FindAllCommand extends Command<dynamic> {
  FindAllCommand(this.studentsRepository);
  final StudentsRepository studentsRepository;

  @override
  String get description => 'Find all students';

  @override
  String get name => 'findAll';

  @override
  Future<void> run() async {
    stdout.writeln('Aguarde buscando dados...');
    final students = await studentsRepository.findAll();

    stdout.writeln('Apresentar também os cursos (S ou N): ');

    final showCourses = stdin.readLineSync();

    stdout
      ..writeln('------------------------------')
      ..writeln('Alunos:')
      ..writeln('------------------------------');

    for (final student in students) {
      if ((showCourses?.toUpperCase() ?? 'N') == 'S') {
        stdout.writeln(
          '${student.id} ${student.name} ${student.courses.where((course) => course.isStudent).map((course) => course.name).toList()}',
        );
      } else {
        stdout.writeln('${student.id} ${student.name}');
      }
    }
  }
}
