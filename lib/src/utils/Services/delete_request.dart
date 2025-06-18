import 'dart:convert';

import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

import 'package:global365_widgets/src/utils/services/response_model/resonse_model.dart';
import 'package:http/http.dart' as http;

class APIDeleteRequest {
  static Future<ResponseModel> deleteById(String requestUrl) async {
    gLogger("Delete Request complete url is: $apiLink$requestUrl");
    gLogger("Delete Request access Token is: $accessToken");

    try {
      final response = await http.delete(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$tokenType $accessToken",
        },
      );

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> deleteByBody(String requestUrl, dynamic data) async {
    try {
      final response = await http.delete(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$tokenType $accessToken",
        },
        body: jsonEncode(data),
      );

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }
}
