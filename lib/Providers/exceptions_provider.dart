import 'package:http/http.dart' as http;

class ExceptionsProvider {
  late String message;

  ExceptionsProvider(dynamic exception) {
    String message = exception.toString();
    if (exception is FormatException) {
      message = "FormatException: ${exception.message}";
    }
    if (exception is http.ClientException) {
      message = "ClientException: ${exception.message}";
    }
    this.message = message;
  }
}
