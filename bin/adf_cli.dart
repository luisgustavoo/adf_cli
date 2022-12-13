import 'package:adf_cli/src/commands/students/students_commands.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  CommandRunner<dynamic>('ADF CLI', 'ADF CLI')
    ..addCommand(StudentsCommands())
    ..run(arguments);
}
