// import 'package:global365_widgets/src/constants/globals.dart';
// import 'package:global365books/core/constants/globals.dart';
// import 'package:http/http.dart' as http;

// class Service {
//   static Future<String> login(String username, String password) async {
//     // dynamic data = {
//     //   'username': username,
//     //   'password': password,
//     //   'grant_type': 'password',
//     //   'user_ip': "data.toString()",
//     //   'user_mac_address': "macAddress"
//     // };
//     // final response = await http.post(
//     //   Uri.parse(apiLink + "/login"),
//     //   headers: <String, String>{'Accept': 'application/json', 'Content-Type': 'application/x-www-form-urlencoded'},
//     //   body: jsonEncode(data),
//     // );

//     // final res = ResponseModel(statusCode: response.statusCode, data: response.body);
//     // print(res.data);

//     var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
//     var request = http.Request('GET', Uri.parse('$apiLink/login'));
//     request.bodyFields = {'username': username, 'grant_type': 'password', 'password': password};
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       String res = await response.stream.bytesToString();
//       return res;
//     } else {
//       // Dialogue.showMessage("Invalid Username or Password");
//       return "";
//     }
//   }
// }
