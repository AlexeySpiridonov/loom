import 'package:logger/logger.dart';

String allLogs = "";

class LoomConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      print(line);
      allLogs += line + "\n";
    }
  }
}
