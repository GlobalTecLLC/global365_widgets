class ResponseModel {
  int statusCode;

  dynamic data;
  ResponseModel({required this.statusCode, required this.data});
}

class ValidateModel {
  bool isValid;

  dynamic data;
  ValidateModel({required this.isValid, required this.data});
}
