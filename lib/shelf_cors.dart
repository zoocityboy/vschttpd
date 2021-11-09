import 'package:shelf/shelf.dart';

Middleware corsHeadersMiddleware({Map<String, String>? corsHeaders}) {
  corsHeaders ??= {
    'X-Frame-Options': 'SAMEORIGIN',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,OPTIONS',
    'Access-Control-Allow-Header':
        'Content-Type, X-Requested-With, Authorization',
    'Access-Control-Allow-Credentials': 'true',
    'X-XSS-Protection': '0',
    'Cache-Control': 'public, max-age=0',
    'X-Powered-By': 'vschttpd',
  };

  Response? handleOptionsRequest(Request request) {
    if (request.method == 'OPTIONS') {
      return Response.ok(null, headers: corsHeaders);
    } else {
      return null;
    }
  }

  Response addCorsHeaders(Response response) =>
      response.change(headers: corsHeaders);

  return createMiddleware(
      requestHandler: handleOptionsRequest, responseHandler: addCorsHeaders);
}
