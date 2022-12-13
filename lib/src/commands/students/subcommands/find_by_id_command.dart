import 'dart:io';

import 'package:adf_cli/src/repositories/students_repository.dart';
import 'package:args/command_runner.dart';

class FindByIdCommand extends Command<dynamic> {
  FindByIdCommand(this.studentsRepository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }
  final StudentsRepository studentsRepository;

  @override
  String get description => 'Find Students By Id';

  @override
  String get name => 'byId';

  @override
  Future<void> run() async {
    final id = int.tryParse(argResults?['id'] as String? ?? '');

    if (id == null) {
      stderr.writeln('Por favor envie o parametro --id=(0-9) ou -i (0-9)');
      return;
      // exit(2);
    }

    stdout.writeln('Agurade buscando dados...');
    final student = await studentsRepository.findById(id);
    stdout
      ..writeln('----------------------------')
      ..writeln('Aluno: ${student.name}')
      ..writeln('----------------------------')
      ..writeln('Nome: ${student.name}')
      ..writeln('Idade: ${student.age ?? 'Não informado'}')
      ..writeln('Curso: ');
    student.nameCourses.forEach(stdout.writeln);
    stdout
      ..writeln('Endereço :')
      ..writeln('  ${student.address.street}  (${student.address.zipCode})');
  }
}
