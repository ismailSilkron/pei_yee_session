class ErrorEntity {
  final int? code;
  final String? message;
  final Map<String, dynamic>? response;

  ErrorEntity({this.code, this.message, this.response});

  @override
  String toString() {
    return "ErrorEntity{ code: $code, message: $message, response: $response }";
  }
}
