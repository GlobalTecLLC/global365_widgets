import 'dart:convert';

import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/Services/ResponseModel/FileModel/multipart_file_model.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:global365_widgets/src/utils/services/response_model/resonse_model.dart';

class APIsCallPut {
  static Future<ResponseModel> updateRequestWithIdwithoutbody(String requestUrl) async {
    gLogger("Acces toke put $accessToken");
    gLogger("Request URL $requestUrl");
    try {
      final response = await http.put(
        Uri.parse("$apiLink$requestUrl"),
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

  static Future<ResponseModel> updateRequestWithId(String requestUrl, dynamic data) async {
    gLogger("Acces toke put $accessToken");
    try {
      final response = await http.put(
        Uri.parse("$apiLink$requestUrl"),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$tokenType $accessToken",
        },
        body: jsonEncode(data),
      );

      gLogger(data);

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> updateRequestWithIdwithoutbodyWithOutAuth(String requestUrl) async {
    // gLogger("Acces toke put $accessToken");
    gLogger("Request URL $apiLink$requestUrl");
    try {
      final response = await http.put(
        Uri.parse("$apiLink$requestUrl"),
        // headers: <String, String>{'Accept': 'application/json', 'Content-Type': 'application/json; charset=UTF-8', 'Authorization': "$tokenType $accessToken"},
      );

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> updateRequestWithIdWithFile(
    String requestUrl,
    Map<String, String> data,
    List<MultiPartFileModel> list,
  ) async {
    try {
      // print(tokenType + " " + accessToken);

      gLogger("Data:${jsonEncode(data)}");
      // gLogger("Link:$apiLink$requestUrl");
      var headers = {'Authorization': '$tokenType $accessToken'};
      final request = http.MultipartRequest('PUT', Uri.parse(apiLink + requestUrl));
      for (int i = 0; i < list.length; i++) {
        final fileBytes = list[i].fileBytes;
        final fileName = list[i].fileName;
        final mimeType = list[i].mimeType;
        final multipartFile = http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        );
        request.files.add(multipartFile);
      }

      request.fields.addAll(data);

      request.headers.addAll(headers);
      final response = await request.send();

      if (response.statusCode == 500) {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());

        return ResponseModel(statusCode: response.statusCode, data: res);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> updateRequestWithIdId(String requestUrl, int id, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse("$apiLink$requestUrl$id"),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$tokenType $accessToken",
        },
        body: jsonEncode(data),
      );

      gLogger(data);

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static String method2() {
    /*...*/
    return "Some string";
  }
}
