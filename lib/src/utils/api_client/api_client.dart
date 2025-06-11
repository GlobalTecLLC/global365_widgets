import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/utils/api_client/resonse_model.dart';
import 'package:global365_widgets/src/utils/api_constant.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/progressDialog.dart';

class ApiCalls {
  // static final DioClient _dioClient = DioClient();
  static late Dio dioClient;
  static late String authToken;
  // static Dio dioClient = Dio(
  //     BaseOptions(baseUrl: ApiConstant.baseUrl, connectTimeout: Duration(seconds: 100), receiveTimeout: Duration(seconds: 100)));
  // ..interceptors.add(SSLPinningInterceptor.fromCertFiles([File("assets/certificate.pem")]));
  static Future<void> initialize() async {
    // Load the certificate as bytes from the asset bundle
    // ByteData certificateData = await rootBundle.load('assets/certificate.pem');
    // List<int> certBytes = certificateData.buffer.asUint8List();

    // Set up the Dio instance with SSL pinning
    dioClient = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: Duration(seconds: 100), // Adjust as needed
        receiveTimeout: Duration(seconds: 100), // Adjust as needed
      ),
    );
    setAuthToken("");
    // // Add the certificate as a trusted root CA
    // // Use `createHttpClient` for SSL pinning
    // (dioClient.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //   SecurityContext context = SecurityContext();
    //   context.setTrustedCertificatesBytes(certBytes); // Add trusted certificates

    //   return HttpClient(context: context);
    // };
  }

  static Future<void> setAuthToken(String token) async {
    authToken = token;
  }

  static Options getAuth(bool isAuth, {bool isFSAPI = false}) {
    //  'Co-RelationID': AccountService.getCorelationID()
    return isAuth ? Options(headers: {'Authorization': 'Bearer $authToken'}) : Options(headers: {});
  }

  ///
  ///Url : pass end point without base url
  ///isAuth : pass false if you want to call post API without auth token true is set as defualt
  ///
  static Future<ResponseModel> getAPICall(
    BuildContext context, {
    required String url,
    bool isAuth = true,
    bool showError = true,
  }) async {
    // addInterceptor(isAuth: isAuth);
    try {
      log('this is my userToken $authToken');
      gLogger("This is my Token: $authToken");
      gLogger("API URL: ${ApiConstant.baseUrl + url}");

      final response = await dioClient.get(ApiConstant.baseUrl + url, options: getAuth(isAuth));
      if (response.statusCode == 200) {
        gLogger("Response: ${jsonEncode(response.data)}");
        return ResponseModel(statusCode: 200, data: response.data);
      } else {
        return ResponseModel(statusCode: response.statusCode ?? -1, data: response.data);
      }
      // return response.data;
    } on DioException catch (error) {
      gLogger("Error: ${error.response?.data}");
      return handleErrorResponses(context, error, isShowError: showError);
    } catch (error) {
      return ResponseModel(statusCode: -1, data: error.toString());
    }
  }

  ///
  ///Url : pass end point without base url
  ///bodyParams : pass body params
  ///isAuth : pass false if you want to call post API without auth token true is set as defualt
  ///

  static Future PUTAPICall(
    BuildContext context, {
    required String url,
    required dynamic data,
    bool isShowError = true,
    bool isAuth = true,
  }) async {
    gLogger('toke $authToken');
    gLogger("API URL: ${ApiConstant.baseUrl + url}");

    try {
      final response = await dioClient.put(ApiConstant.baseUrl + url, data: data, options: getAuth(isAuth));
      gLogger("Status Code: ${response.statusCode}");
      gLogger("Response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return ResponseModel(data: response.data, statusCode: 200);
      } else if (response.statusCode == 400) {
        showCustomDialog();
      } else if (response.statusCode == 400) {
        showCustomDialog();
        return ResponseModel(data: response.data, statusCode: 400);
      } else if (response.statusCode == 501) {
        return ResponseModel(data: response.data, statusCode: 501);
      } else {
        return ResponseModel(data: response.data, statusCode: -1);
      }
      return response.data;
    } on DioException catch (error) {
      gLogger("Error: ${error.response?.data}");
      return handleErrorResponses(context, error, isShowError: isShowError);
    } catch (error) {
      return ResponseModel(statusCode: -1, data: error.toString());
    }
  }

  ///
  ///Url : pass end point without base url
  ///bodyParams : pass body params
  ///isAuth : pass false if you want to call post API without auth token true is set as defualt
  ///
  static Future<ResponseModel> POSTAPICall(
    BuildContext context, {
    required String url,
    required dynamic data,
    bool isAuth = true,
    bool isShowError = true,
    bool isFSAPI = false,
  }) async {
    gLogger("API URL: ${ApiConstant.baseUrl + url}");

    try {
      try {
        gLogger(jsonEncode(data));
      } catch (e) {
        gLogger(data);
      }
      if (isAuth) {
        gLogger('Bearer $authToken');
      }
      final response = await dioClient.post(
        ApiConstant.baseUrl + url,
        data: data,
        options: getAuth(isAuth, isFSAPI: isFSAPI),
      );
      gLogger("Status Code: ${response.statusCode}");
      gLogger("Response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return ResponseModel(data: response.data, statusCode: 200);
      } else if (response.statusCode == 400) {
        showCustomDialog();
        return ResponseModel(data: response.data, statusCode: 400);
      } else if (response.statusCode == 403) {
        return ResponseModel(data: response.data, statusCode: 403);
      } else if (response.statusCode == 409) {
        return ResponseModel(data: response.data, statusCode: 409);
      } else {
        return ResponseModel(data: response.data, statusCode: -1);
      }
    } on DioException catch (error) {
      if (error.error is TlsException) {
        // Recieved certificate is different from trusted certificates
        gLogger("Error: ${error.error}");
      }
      gLogger("Error: ${error.response?.data}");
      return handleErrorResponses(context, error, isShowError: isShowError);
    } catch (error) {
      return ResponseModel(statusCode: -1, data: error.toString());
    }
  }

  static addInterceptor({bool isAuth = true}) {
    dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the access token to the request header
          if (isAuth) {
            options.headers['Authorization'] = 'Bearer $authToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access token
            String newAccessToken = await refreshToken();
            //Handle expcetion
            if (newAccessToken == "") {
              return handler.reject(e);
            }

            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            // Repeat the request with the updated header
            return handler.resolve(await dioClient.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }

  static Timer? timer;
  static bool isTimerRunning = false;
  static refreshTokenProdicaly() {
    if (isTimerRunning) return;
    isTimerRunning = true;
    gLogger("Timer Started Running");
    timer = Timer.periodic(Duration(seconds: 55), (timer) async {
      String newAccessToken = await refreshToken();
      if (newAccessToken == "") {
        isTimerRunning = false;
        timer.cancel();
      }
    });
  }

  static stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  static refreshToken() async {
    // // Implement the logic to refresh the access token
    // gLogger("Called This on Token Expired");
    // var headers = {'Content-Type': 'application/json'};
    // gLogger(PrefUtils().getUserRefreshToken());
    // var data = json.encode({
    //   "refreshToken": PrefUtils().getUserRefreshToken(), // The refresh token stored in the app
    // });
    // var dio = Dio();
    // var response = await dio.request(
    //   'http://172.174.245.80:3000/v1/auth/refreshToken',
    //   options: Options(method: 'POST', headers: headers),
    //   data: data,
    // );

    // if (response.statusCode == 200) {
    //   PrefUtils().setUserToken(response.data['accessToken'], response.data['refreshToken']);
    //   return response.data['accessToken'];
    // } else {
    //   return "";
    // }
    // // if (response.statusCode == 200) {
    // //   PrefUtils().setUserToken(
    // //       response.data['accessToken'], response.data['refreshToken']);
    // //   return response.data['accessToken'];
    // // } else {
    // //   return "";
    // // }
  }

  // static Future<ResponseModel> POSTAPICallWithFormData({required String url, required FormData formData}) async {
  //   try {
  //     final response = await dioClient.post(ApiConstant.baseUrl + url, data: formData);

  //     if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
  //       return ResponseModel(statusCode: 200, data: response.data);
  //     } else if (response.statusCode == 400) {
  //       showCustomDialog();
  //       return ResponseModel(statusCode: 400, data: response.data);
  //     }
  //     return response.data;
  //   } on DioException catch (error) {
  //     return handleErrorResponses(error);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  static Future DELETEAPICall(
    BuildContext context, {
    required String url,
    bool isAuth = true,
    bool isShowError = true,
    required dynamic bodyParams,
  }) async {
    gLogger("API URL: ${ApiConstant.baseUrl + url}");

    try {
      final response = await dioClient.delete(ApiConstant.baseUrl + url, data: bodyParams, options: getAuth(isAuth));
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return ResponseModel(data: response.data, statusCode: 200);
      } else if (response.statusCode == 400) {
        showCustomDialog();
        return ResponseModel(data: response.data, statusCode: 400);
      } else if (response.statusCode == 409) {
        showCustomDialog();
        return ResponseModel(data: response.data, statusCode: 409);
      } else if (response.statusCode == 501) {
        // showCustomDialog();
        return ResponseModel(data: response.data, statusCode: 501);
      } else {
        return ResponseModel(data: response.data, statusCode: -1);
      }
    } on DioException catch (error) {
      gLogger("Error: ${error.response?.data}");
      return handleErrorResponses(context, error, isShowError: isShowError);
    } catch (error) {
      // gLogger("data: ")
      return ResponseModel(statusCode: -1, data: error.toString());
    }
  }

  static Future PATCHAPICall({required String url, required dynamic bodyParams, bool? fromEditProfile}) async {
    // try {
    //   final response = await dioClient.patch(url, data: bodyParams);
    //   gLogger("Status Code: ${response.statusCode}");
    //   gLogger("Response: ${response.data}");
    //   if (response.statusCode == 400) {
    //     showCustomDialog();
    //   }
    //   if (response.statusCode == 200) {
    //     GProgressDialog(context).hide();
    //     if (fromEditProfile == true) {
    //       await PrefUtils().setUserDetails(jsonEncode(response.data));
    //       GToast.success('msg_profile_updated');
    //     }

    //     return response.data;
    //   }
    //   return response.data;
    // } on DioException catch (error) {
    //   return handleErrorResponses(error);
    // } catch (error) {
    //   rethrow;
    // }
  }

  static Future<ResponseModel> handleErrorResponses(
    BuildContext context,
    DioException error, {
    bool? fromEditProfile,
    bool isShowError = true,
  }) async {
    try {
      GProgressDialog(context).hide();
    } catch (e) {}

    if (error.response?.statusCode == 401) {
      // GToast.error(error.response?.data?['message'] ?? '');

      return ResponseModel(statusCode: 401, data: "Unauthorised");
    } else if (error.response?.statusCode == 403) {
      return ResponseModel(statusCode: 403, data: error.response?.data['message']);
    } else if (error.response?.statusCode == 400) {
      // G.Get.snackbar('Error', error.response?.data?['errors'][0]??'');
      if (isShowError) GToast.error(error.response?.data['message'] ?? '', context);

      return ResponseModel(statusCode: 400, data: error.response?.data['message'] ?? '');
    } else if (error.response?.statusCode == 500) {
      if (isShowError) GToast.error(error.response?.data['message'], context);
      gLogger("status code: ${error.response}");
      return ResponseModel(statusCode: 500, data: error.response?.data['message']);
    } else if (error.response?.statusCode == 501) {
      gLogger("status code: ${error.response}");
      if (isShowError) GToast.error(error.response?.data['message'], context);

      return ResponseModel(statusCode: 501, data: error.response?.data['message']);
    } else if (error.response?.statusCode == 502) {
      if (isShowError) GToast.error(error.response?.data['message'], context);

      gLogger("status code: ${error.response}");
      return ResponseModel(statusCode: 502, data: error.response?.data['message']);
    } else if (error.response?.statusCode == 404) {
      if (isShowError) GToast.error(error.response?.data['message'] ?? '', context);
      return ResponseModel(statusCode: -1, data: error.response?.data['message'] ?? '');
      // throw ApiResponseException(error.response?.data?['errors'][0] ?? '');
    } else if (error.response?.statusCode == 409) {
      if (isShowError) {
        if (error.response?.data?['message'] ==
            "You can't leave the circle. You have bills that you haven't settled.") {
        } else {
          GToast.error(error.response?.data?['message'] ?? '', context);
        }
      }

      return ResponseModel(statusCode: 409, data: error.response?.data?['message'] ?? '');
    } else if (error.response?.statusCode == 413) {
      if (isShowError) GToast.error((error.response?.data ?? "").toString(), context);

      return ResponseModel(statusCode: -1, data: error.response?.data?['message'] ?? '');
    } else if (error.response?.statusCode == 422) {
      if (isShowError) GToast.error(error.response?.data?['message'] ?? '', context);
      return ResponseModel(statusCode: -1, data: error.response?.data['message'] ?? '');
    } else {
      if (isShowError) GToast.error("msg_something_wrong", context);
      return ResponseModel(statusCode: -1, data: error.response?.data ?? "");
    }
  }

  static Future<dynamic> downloadFile({required String downLoadFileUrl}) async {
    // try {
    //   String dir = "";
    //   if (Platform.isAndroid) {
    //     dir = "/storage/emulated/0/Download";
    //   } else if (Platform.isIOS) {
    //     dir = (await getApplicationDocumentsDirectory()).path;
    //   }
    //   final String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
    //   final fileExtension = getFileExtensionFromUrl(downLoadFileUrl);
    //   String locationPath = "$dir/myipr_file_$uniqueFilename.$fileExtension";
    //   gLogger('location: $locationPath');
    //   Dio dio = Dio();
    //   await dio.download(downLoadFileUrl, locationPath);
    //   gLogger('filepath: $downLoadFileUrl');
    //   return locationPath;
    // } on DioException catch (error) {
    //   return handleErrorResponses(error);
    // } catch (error) {
    //   rethrow;
    // }
  }

  // static String getFileExtensionFromUrl(String fileUrl) {
  //   // final Uri uri = Uri.parse(fileUrl);
  //   // final String path = uri.path;
  //   // final String extension = p.extension(path);
  //   // return extension.isNotEmpty ? extension.substring(1) : '';
  // }

  static void showCustomDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // This makes the dialog rectangular
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Session Expired", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 16),
              Text("Your session has expired. Please login again."),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, right: 30, bottom: 8.0, left: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          // G.Get.offAll(LoginScreen());
                          // Button 2 action
                          gLogger("Button 2 pressed");
                        },
                        child: Text('Login Again', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Set to true if you want the dialog to be dismissible by tapping outside of it.
    );
  }
}
