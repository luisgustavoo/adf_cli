import 'package:adf_cli/src/commands/students/subcommands/find_all_command.dart';
import 'package:adf_cli/src/commands/students/subcommands/find_by_id_command.dart';
import 'package:adf_cli/src/repositories/students_repository.dart';
import 'package:args/command_runner.dart';

class StudentsCommands extends Command<dynamic> {
  StudentsCommands() {
    final studentsRepository = StudentsRepository();
    addSubcommand(FindAllCommand(studentsRepository));
    addSubcommand(FindByIdCommand(studentsRepository));
  }

  @override
  String get description => 'Students Operation';

  @override
  String get name => 'students';
}
