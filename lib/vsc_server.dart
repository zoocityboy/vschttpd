import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:vschttpd/server.dart';

Future<VscHttpDeamon?> main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('port',
      abbr: 'p', defaultsTo: '9001', help: 'Port to listen on.');
  parser.addOption('root',
      abbr: 'r',
      help: 'The path to serve. If not set, the current directory is used.',
      mandatory: true);
  parser.addOption(
    'address',
    abbr: 'a',
    defaultsTo: 'localhost',
    help: 'Address to listen on. ',
  );
  try {
    var args = parser.parse(arguments);
    final port = int.parse(args['port']);
    final path = args['root'] ?? Directory.current.path;
    final address = args['address'];

    final server =
        await VscHttpDeamon.start(path: path, port: port, address: address);

    print("Local server started on port: ${server.urlBase}.");
    print("Use Ctrl-C (SIGINT) to stop running the application.");
    return server;
  } on UsageException catch (e, _) {
    print(e.message);
    print(parser.usage);
    exit(1);
  } catch (e) {
    print(e);
    print(parser.usage);
    exit(1);
  }
}
