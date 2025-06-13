// import 'dart:convert';

// import 'package:global365books/core/constants/globals.dart';
// import 'package:global365books/core/utils/print_log.dart';
// import 'package:http/http.dart' as http;

// import 'ResponseModel/resonse_model.dart';

// class APIsCall {
//   static Future<ResponseModel> followSubmitRequest(String requestUrl) async {
//     try {
//       // print(tokenType + " " + accessToken);

//       // print("Data:" + jsonEncode(data).toString());
//       gLogger("Link:" + apiLink + requestUrl);

//       final response = await http.post(
//         Uri.parse(apiLink + requestUrl),
//         headers: <String, String>{
//           'Accept': 'application/json',
//           'Content-Type': 'application/json; charset=UTF-8',
//           // 'Authorization': tokenType + " " + accessToken
//         },
//       );

//       if (response.statusCode == 500) {
//         dynamic res = jsonDecode(response.body);
//         return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
//       } else if (response.statusCode == 401) {
//         // MyToast.error("Unauthorized User");
//         return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
//       } else if (response.statusCode == 403) {
//         // MyToast.error("Forbidden Access");
//         return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
//       } else {
//         return ResponseModel(statusCode: response.statusCode, data: response.body);
//       }
//     } catch (e) {
//       final res = ResponseModel(statusCode: -1, data: e.toString());
//       return res;
//     }
//   }

//   static String method2() {
//     /*...*/
//     return "Some string";
//   }
// }
