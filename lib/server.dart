import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:vschttpd/shelf_cors.dart';

class VscHttpDeamon {
  final HttpServer _server;
  HttpServer get server => _server;
  final String path;

  VscHttpDeamon._(this._server, this.path);

  String get host => _server.address.host;

  int get port => _server.port;

  String get urlBase => 'http://$host:$port/';

  static Future<VscHttpDeamon> start({
    String? path,
    int port = 9001,
    Object address = 'http://localhost',
  }) async {
    path ??= Directory.current.path;

    final pipeline = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeadersMiddleware())
        .addHandler(createStaticHandler(path, defaultDocument: 'index.html'));
    final server = await io.serve(pipeline, address, port);
    server.defaultResponseHeaders.remove('X-Content-Type-Options', 'nosniff');
    server.defaultResponseHeaders.remove('x-content-type-options', 'nosniff');
    return VscHttpDeamon._(server, path);
  }

  Future<void> destroy() {
    return _server.close(force: true);
  }
}
