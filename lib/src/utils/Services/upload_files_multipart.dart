import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/services/response_model/resonse_model.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:http/http.dart' as http;

class UploadFilesServices {
  static Future<ResponseModel> uploadFile(List<dynamic> listOfFiles, String url, BuildContext context) async {
    gLogger("listOfFiles=====$listOfFiles");
    gLogger("Upload Function ${Uri.parse('${apiLink}$url')}");
    var headers = {'Authorization': '$tokenType $accessToken'};

    var request = http.MultipartRequest('POST', Uri.parse('${apiLink}$url'));

    if (kIsWeb) {
      for (int i = 0; i < listOfFiles.length; i++) {
        dynamic file = listOfFiles[i];

        if (file["filePath"] == null || file["fileName"] == null) {
          gLogger("Error: filePath or fileName is null for file $i");
          continue;
        }

        try {
          gLogger("Downloading file from URL: ${file["filePath"]}");

          // Fetch the file from the URL
          var response = await http.get(Uri.parse(file["filePath"]));

          if (response.statusCode == 200) {
            List<int> fileBytes = response.bodyBytes;

            request.files.add(http.MultipartFile.fromBytes('files', fileBytes, filename: file["fileName"]));

            gLogger("File added successfully: ${file["fileName"]}");
          } else {
            gLogger("Error: Failed to download file, status: ${response.statusCode}");
          }
        } catch (e) {
          gLogger("Error fetching file: $e");
        }
      }
    } else if (GetPlatform.isMacOS) {
      for (int i = 0; i < listOfFiles.length; i++) {
        dynamic file = listOfFiles[i];
        String path = file["filePath"].toString();
        gLogger("send request http MacOs");
        request.files.add(await http.MultipartFile.fromPath('files', path));
      }
    } else {
      for (int i = 0; i < listOfFiles.length; i++) {
        dynamic file = listOfFiles[i];
        String name = file["filePath"].toString();
        gLogger("send request http other");
        request.files.add(await http.MultipartFile.fromPath('files', name));
      }
    }
    gLogger("request=============");

    request.headers.addAll(headers);
    gLogger("request.headers================$headers");

    http.StreamedResponse response = await request.send();

    gLogger(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(await response.stream.bytesToString());
      gLogger("jsonResponse $jsonResponse");
      List<dynamic> payloadData = jsonResponse['payload'];
      return ResponseModel(statusCode: 200, data: jsonResponse);
    } else {
      gLogger(response.reasonPhrase);
      return ResponseModel(statusCode: response.statusCode, data: response.reasonPhrase);
    }
  }
}
