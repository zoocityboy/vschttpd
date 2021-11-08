import 'dart:async';
import 'dart:io';

import 'package:vschttpd/server.dart';
import 'package:vschttpd/vsc_server.dart' as vschttpd;

void main(List<String> arguments) {
  VscHttpDeamon? _server;
  runZonedGuarded(() async {
    ProcessSignal.sigint.watch().listen((event) async {
      if (_server != null) {
        print(
            'Killing vschttpd Server at ${_server?.urlBase} ${_server?.port}');
        await _server?.destroy();
        print('Stoped');
      }
      exit(0);
    });
    _server = await vschttpd.main(arguments);
  }, (e, stackTrace) => print("Uncaught error: $e\n$stackTrace"));
}
