import 'dart:io';

import 'package:args/args.dart';
import 'package:vschttpd/server.dart';

Future<VscHttpDeamon?> main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('port',
      abbr: 'p', defaultsTo: '9001', help: 'Port to listen on.');
  parser.addOption('root',
      abbr: 'r',
      help: 'The path to serve. If not set, the current directory is used.');
  parser.addOption(
    'address',
    abbr: 'a',
    defaultsTo: 'localhost',
    help: 'Address to listen on. ',
  );
  try {
    var args = parser.parse(arguments);
    final port = int.parse(args['port']);
    final path = args['path'] ?? Directory.current.path;
    final address = args['address'];

    final server =
        await VscHttpDeamon.start(path: path, port: port, address: address);

    print(
        "Application started on port: http://${server.urlBase}:${server.port}.");
    print("Use Ctrl-C (SIGINT) to stop running the application.");
    return server;
  } catch (e) {
    print(e);
    print(parser.usage);
  }
}
