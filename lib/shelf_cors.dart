import 'package:shelf/shelf.dart';

/// Middleware which adds [CORS headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
/// to shelf responses. Also handles preflight (OPTIONS) requests.
Middleware corsHeadersMiddleware({Map<String, String>? corsHeaders}) {
  if (corsHeaders == null) {
    // By default allow access from everywhere.
    corsHeaders = {
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
  }
  // Handle preflight (OPTIONS) requests by just adding headers and an empty
  // response.
  Response? handleOptionsRequest(Request request) {
    if (request.method == 'OPTIONS') {
      return new Response.ok(null, headers: corsHeaders);
    } else {
      return null;
    }
  }

  Response addCorsHeaders(Response response) =>
      response.change(headers: corsHeaders);

  return createMiddleware(
      requestHandler: handleOptionsRequest, responseHandler: addCorsHeaders);
}
