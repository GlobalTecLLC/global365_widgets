// import 'dart:async';
// import 'dart:convert';

// import 'package:auto_route/auto_route.dart';
// import 'package:dart_ipify/dart_ipify.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:global365books/Languages/Languages.dart';
// import 'package:global365books/Services/ResponseModel/resonse_model.dart';
// import 'package:global365books/Services/get_request.dart';
// import 'package:global365books/core/app_export.dart';
// import 'package:global365books/core/constants/globals.dart' as globals;
// import 'package:global365books/pages/Customer/Widgets/IntlFoneField/intl_phone_field.dart';
// import 'package:global365books/routes_auto/go_routes.dart';
// import 'package:global365books/routes_auto/routes_import.gr.dart';
// import 'package:global365books/theme/Text/TextVariants/text_heading4.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// import 'package:local_auth/local_auth.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// // import 'package:get_ip_address/get_ip_address.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:universal_platform/universal_platform.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:validators/validators.dart' as validator;

// import '../../Widgets/bezierContainer.dart';
// import '../../Widgets/custom_textfield.dart';
// import 'forgetPassword.dart';

// @RoutePage()
// class LoginPage extends StatefulWidget {
//   LoginPage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // WifiInfoWrapper _wifiObject;
//   // Future<void> initPlatformState() async {
//   //   WifiInfoWrapper wifiObject;
//   //   // Platform messages may fail, so we use a try/catch PlatformException.
//   //   try {
//   //     wifiObject = await WifiInfoPlugin.wifiDetails;
//   //   } on PlatformException {}
//   //   if (!mounted) return;

//   //   setState(() {
//   //     _wifiObject = wifiObject;
//   //   });
//   // }

//   Widget _backButton() {
//     return InkWell(
//       onTap: () {
//         if (kIsWeb) {}
//         Navigator.pop(context);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//               child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
//             ),
//             Text(T("login_back"), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
//           ],
//         ),
//       ),
//     );
//   }

//   TextEditingController controllerusernmae = TextEditingController();
//   TextEditingController controllerpassword = TextEditingController();
//   TextEditingController controllerEmail = TextEditingController();

//   String usernmae = "";
//   String password = "";
//   Future<void> loginCustomerBioMetric() async {
//     // var ipAddress = IpAddress(type: RequestType.text);
//     // dynamic data = await ipAddress.getIpAddress();
//     // String ipAddress =
//     //     _wifiObject != null ? _wifiObject.ipAddress.toString() : "ip";
//     // String macAddress =
//     //     _wifiObject != null ? _wifiObject.macAddress.toString() : "mac";
//     // gLogger(ipAddress + macAddress);
//     setState(() {
//       loogingIn = true;
//     });
//     var headers = {'Accept': 'application/json', 'Content-Type': 'application/x-www-form-urlencoded'};
//     var request = http.Request('POST', Uri.parse(globals.apiLink + 'login'));
//     request.bodyFields = {'username': usernmae, 'password': password, 'grant_type': 'password', 'user_ip': "data.toString()", 'user_mac_address': "macAddress"};
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();
//     // gLogger(await response.stream.bytesToString());
//     // gLogger(response.statusCode.toString());

//     // setState(() {
//     //   loogingIn = false;
//     // });
//     if (response.statusCode == 200) {
//       String responseString = await response.stream.bytesToString();
//       dynamic parsed = jsonDecode(responseString);
//       globals.accessToken = parsed['access_token'].toString();
//       globals.tokenType = parsed['token_type'].toString();
//       // if (isDebug)
//       gLogger(parsed['token_type'].toString() + " " + parsed['access_token'].toString());
//       globals.isFirstpurchase = false;
//       getCustomerData(parsed['access_token'].toString(), parsed['token_type'].toString());
//       //   //gLogger(parsed.toString());
//     } else if (response.statusCode == 400) {
//       showAlertGlobal(context, T("login_Username_or_password"));
//       // showDialog(
//       //     context: context,
//       //     builder: (context) {
//       //       return CustomDialog(
//       //         title: "Genial365",
//       //         content: "",
//       //         positiveBtnText: "Done",
//       //         negativeBtnText: "Cancel",
//       //         child: Text("Username or password is incorrect"),
//       //         positiveBtnPressed: () {
//       //           // Do something here
//       //           Navigator.of(context).pop();
//       //         },
//       //       );
//       //     });
//     } else {
//       showAlertGlobal(context, T("login_Some_Error_Ocurred"));
//       // showDialog(
//       //     context: context,
//       //     builder: (context) {
//       //       return CustomDialog(
//       //         title: "Sindbaad",
//       //         content: "",
//       //         positiveBtnText: "Done",
//       //         negativeBtnText: "Cancel",
//       //         child: Text("Some Error Ocurred, Please try again"),
//       //         positiveBtnPressed: () {
//       //           // Do something here
//       //           Navigator.of(context).pop();
//       //         },
//       //       );
//       //     });
//     }
//   }

//   @override
//   void initState() {
//     checkversion();
//     getIPAddress();
//     if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
//       // initDynamicLinks();
//     }
//   }

//   getIPAddress() async {
//     try {
//       gLogger("Loading API");
//       final ipv4 = await Ipify.ipv4();

//       setState(() {
//         ipAddressglobal = ipv4;
//       });
//       gLogger(ipv4);
//     } on Exception catch (e) {
//       gLogger("Can't get IPv4 address: $e");
//     }
//   }

//   // void initDynamicLinks() async {
//   //   try {
//   //     FirebaseDynamicLinks.instance.onLink;

//   //     final PendingDynamicLinkData? data =
//   //         await FirebaseDynamicLinks.instance.getInitialLink();
//   //     final Uri? deepLink = data?.link;
//   //     gLogger("Data print from deep link" + data.toString());
//   //     // gLogger("deepLinkPath"+deepLink!.path.toString());xx
//   //     if (deepLink != null) {
//   //       String refrealId = "";
//   //       String fragment = deepLink.fragment;
//   //       List<String> list = fragment.split("/");
//   //       if (list.length > 0) {
//   //         refrealId = list[list.length - 1];
//   //       }
//   //       gLogger(refrealId);
//   //       SharedPreferences.getInstance().then((prefs) {
//   //         prefs.setString('refrealKey', refrealId);
//   //       });
//   //       setState(() {
//   //         referralCode = refrealId;
//   //         isFirstpurchase = true;

//   //         // Modular.to.pushNamed("/SubscriptionPlans");
//   //       });
//   //     } else {
//   //       gLogger("deepLinkPathIsNull" + deepLink.toString());
//   //     }
//   //   } catch (e) {
//   //     gLogger(e);
//   //   }
//   // }

//   checkversion() async {
//     // var map = await Firestore.instance
//     //     .collection("users")
//     //     .document("nZUspeRytUmDwTpj8zaE")
//     //     .get();
//     // gLogger(map.map);
//     // map.map["version"]
//     int versionCode = 2;

//     if (globalversionCode == versionCode) {
//       SharedPreferences.getInstance().then((prefs) {
//         if (prefs.getBool("loginWithEmail") != null) {
//           setState(() {
//             checkedValueEmailLogin = prefs.getBool("loginWithEmail")!;
//           });
//         }
//         if (prefs.getBool('biometricEnable') != null) {
//           bool flag = prefs.getBool('biometricEnable')!;
//           setState(() {
//             isSwitched = flag;
//           });
//           if (flag) {
//             SharedPreferences.getInstance().then((prefs) {
//               if (prefs.getStringList('loginDetailsBiometric') != null && prefs.getStringList('loginDetailsBiometric')!.length > 0) {
//                 List temp = prefs.getStringList('loginDetailsBiometric')!;

//                 // gLogger(temp);
//                 usernmae = temp[0];
//                 password = temp[1];
//                 // gLogger(usernmae + password);
//                 if (!kIsWeb) {
//                   _authenticate();
//                 }
//               } else {}
//             });
//           }
//         }
//         if (prefs.getBool('remeberMe') != null) {
//           bool flag = prefs.getBool('remeberMe')!;

//           if (flag) {
//             setState(() {
//               maskFormatter = new MaskTextInputFormatter(
//                   initialText: prefs.getString('usernameforRemeberMe'), mask: '*##-#######', filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[1-9]')});
//               checkedValue = true;
//             });

//             controllerpassword.text = prefs.getString('passwordforremeberMe').toString();
//             if (checkedValueEmailLogin) {
//               controllerEmail.text = prefs.getString('usernameforRemeberMe').toString();
//             } else {
//               controllerusernmae.text = prefs.getString('usernameforRemeberMe').toString().replaceAll("+92", "");

//               phoneNumber = prefs.getString('usernameforRemeberMe').toString();
//             }
//           }
//         }
//       });

//       // initPlatformState();

//       if (!kIsWeb) {
//         _checkBiometric();
//         _getAvailableBiometrics();
//       }
//     } else {
//       showDialogeUpdateApplication(context);
//     }
//   }

//   bool loogingIn = false;
//   Future<void> loginCustomer() async {
//     // var map = await Firestore.instance
//     //     .collection("users")
//     //     .document("nZUspeRytUmDwTpj8zaE")
//     //     .get();
//     // gLogger(map.map);

//     // int versionCode = map.map["version"];
//     int versionCode = 2;

//     if (globalversionCode == versionCode) {
//       SharedPreferences.getInstance().then((prefs) {
//         prefs.setBool('loginWithEmail', checkedValueEmailLogin);
//         if (checkedValue) {
//           prefs.setBool('remeberMe', true);
//           prefs.setString(
//             'usernameforRemeberMe',
//             checkedValueEmailLogin ? controllerEmail.text : phoneNumber,
//           );
//           prefs.setString('passwordforremeberMe', controllerpassword.text);
//         } else {
//           prefs.setBool('remeberMe', false);
//         }
//       });
//       setState(() {
//         loogingIn = true;
//       });
//       gLogger({
//         'username': checkedValueEmailLogin ? controllerEmail.text : phoneNumber.replaceAll("+", ""),
//         'password': controllerpassword.text,
//         'grant_type': 'password',
//         'user_ip': "data.toString()",
//         'user_mac_address': "macAddress"
//       });
//       // var ipAddress = IpAddress(type: RequestType.text);
//       // dynamic data = await ipAddress.getIpAddress();
//       // String ipAddress =
//       //     _wifiObject != null ? _wifiObject.ipAddress.toString() : "ip";
//       // String macAddress =
//       //     _wifiObject != null ? _wifiObject.macAddress.toString() : "mac";
//       // gLogger(ipAddress + macAddress);
//       // ProgressDialogCustom(context).show();
//       var headers = {'Accept': 'application/json', 'Content-Type': 'application/x-www-form-urlencoded'};
//       var request = http.Request('POST', Uri.parse(globals.apiLink + 'login'));
//       request.bodyFields = {
//         'username': checkedValueEmailLogin ? controllerEmail.text : phoneNumber.replaceAll("+", ""),
//         'password': controllerpassword.text,
//         'grant_type': 'password',
//         'user_ip': "data.toString()",
//         'user_mac_address': "macAddress"
//       };
//       request.headers.addAll(headers);
//       // if (isDebug)
//       //   gLogger({
//       //     'username': checkedValueEmailLogin
//       //         ? controllerEmail.text
//       //         : "92" + maskFormatter.getUnmaskedText(),
//       //     'password': controllerpassword.text,
//       //     'grant_type': 'password',
//       //     'user_ip': "data.toString()",
//       //     'user_mac_address': "macAddress"
//       //   });
//       http.StreamedResponse response = await request.send();
//       // gLogger(await response.stream.bytesToString());
//       gLogger(response.statusCode.toString());

//       if (response.statusCode == 200) {
//         SharedPreferences.getInstance().then((prefs) {
//           prefs.setStringList('loginDetailsBiometric', [
//             checkedValueEmailLogin ? controllerEmail.text : phoneNumber.replaceAll("+", ""),
//             controllerpassword.text,
//             // authtype,
//             // authKey,
//             // parsed[0]["login_id"].toString(),
//             // parsed[0]["first_name"].toString(),
//             // parsed[0]["email"].toString(),
//             // parsed[0]["role_id"].toString(),
//             // parsed[0]["chart_id"].toString()
//           ]);
//         });
//         SharedPreferences.getInstance().then((prefs) {
//           prefs.setBool('biometricEnable', isSwitched);
//         });
//         String responseString = await response.stream.bytesToString();
//         dynamic parsed = jsonDecode(responseString);
//         globals.accessToken = parsed['access_token'].toString();

//         globals.tokenType = parsed['token_type'].toString();
//         if (isDebug) gLogger(parsed['token_type'].toString() + " " + parsed['access_token'].toString());
//         getCustomerData(parsed['access_token'].toString(), parsed['token_type'].toString());
//         //   //gLogger(parsed.toString());
//       } else if (response.statusCode == 400) {
//         setState(() {
//           loogingIn = false;
//         });
//         showAlertGlobal(context, T("login_Username_or_password"));
//         // showDialog(
//         //     context: context,
//         //     builder: (context) {
//         //       return CustomDialog(
//         //         title: "Genial365",
//         //         content: "",
//         //         positiveBtnText: "Done",
//         //         negativeBtnText: "Cancel",
//         //         child: Text("Username or password is incorrect"),
//         //         positiveBtnPressed: () {
//         //           // Do something here
//         //           Navigator.of(context).pop();
//         //         },
//         //       );
//         //     });
//       } else {
//         setState(() {
//           loogingIn = false;
//         });
//         String responseString = await response.stream.bytesToString();
//         gLogger(responseString);
//         showAlertGlobal(context, responseString);
//         // showDialog(
//         //     context: context,
//         //     builder: (context) {
//         //       return CustomDialog(
//         //         title: "Sindbaad",
//         //         content: "",
//         //         positiveBtnText: "Done",
//         //         negativeBtnText: "Cancel",
//         //         child: Text("Some Error Ocurred, Please try again"),
//         //         positiveBtnPressed: () {
//         //           // Do something here
//         //           Navigator.of(context).pop();
//         //         },
//         //       );
//         //     });
//       }
//     } else {
//       showDialogeUpdateApplication(context);
//     }
//   }

//   Future<void> getCustomerData(String authKey, String authtype) async {
//     // String ipAddress =
//     //     _wifiObject != null ? _wifiObject.ipAddress.toString() : "ip";
//     // String macAddress =
//     //     _wifiObject != null ? _wifiObject.macAddress.toString() : "mac";
//     // gLogger(ipAddress + macAddress);
//     // ProgressDialogCustom(context).show();

//     ResponseModel response = await APIsCallGet.getData("requestUrl");
//     // await GetAPICall.getwithauth(context, APIs.apilogged_user_info);

//     setState(() {
//       loogingIn = false;
//     });
//     gLogger(response.statusCode);
//     gLogger(response.data);

//     // ProgressDialogCustom(context).hide();
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       //gLogger("Ok");
//       // gLogger(response.body);
//       dynamic parsed = jsonDecode(response.data);
//       if (isPOSOnly) {
//         globals.isShowTahzeeb = (parsed["login_id"].toString() == "7426" || parsed["login_id"].toString() == "733") ? true : false;
//         isFBRIntegrated = (parsed["login_id"].toString() == "7426" || parsed["login_id"].toString() == "783") ? true : false;
//         integrationFee = (parsed["login_id"].toString() == "7426" || parsed["login_id"].toString() == "383") ? 1.0 : 0.0;
//       } else {
//         globals.isShowTahzeeb = false;
//         isFBRIntegrated = false;
//         integrationFee = 1.0;
//       }

//       // gLogger(parsed);
//       gLogger("This is called to assign essential role");
//       gLogger(parsed["role_name"].toString());

//       // gLogger(parsed["user_role_permission"]);
//       List permissions = parsed["user_role_permission"];
//       gLogger('-------------------------------------------');
//       gLogger(permissions);

//       // gLogger("UserPermissions" + objPermissions.toString());

//       dynamic objPermissions = AppFunctions.getPermissions(permissions);
//       setState(() {
//         globals.globalPermissions = objPermissions;
//         globalPermissionsList = permissions;
//         // globals.isEssential = false;
//         globals.isEssential =
//             //  false;
//             (parsed["role_name"].toString() == "Essentials") ? true : false;
//         globals.currencyUnit = parsed["unit_titlecode"] ?? "PKR";
//       });
//       SharedPreferences.getInstance().then((prefs) {
//         prefs.setString("permissions", jsonEncode(objPermissions));
//         prefs.setStringList('loginDetails', [
//           authtype,
//           authKey,
//           parsed["login_id"].toString(),
//           parsed["username"].toString(),
//           parsed["email"].toString(),
//           parsed["role_id"].toString(),
//           parsed["chart_id"].toString(),
//           (parsed["company_name"] ?? "").toString(),
//           (parsed["cell_no"] ?? "").toString(),
//           (parsed["company_email"] ?? "").toString(),
//           (parsed["address"] ?? "").toString(),
//           globals.isEssential.toString(),
//           parsed["user_type"].toString(),
//           parsed["sale_tax_ex_inclusive"].toString(),
//           parsed["invoice_header_no"].toString(),
//           parsed["logo_pic"].toString(),
//           parsed["unit_titlecode"].toString(),
//           parsed["currency_units_id"].toString(),
//         ]);
//       });

//       // globalUserName = parsed["username"].toString();
//       // globalEmail = parsed["email"].toString();
//       // globalroleId = parsed["role_id"].toString();
//       // globalChartId = parsed["chart_id"].toString();
//       // globalLoginId = parsed["login_id"].toString();
//       // gLogger(parsed);

//       globals.regUserEmail = parsed["email"].toString();
//       globals.regUserName = parsed["username"].toString();
//       globals.loginId = parsed["login_id"].toString();

//       globals.reguserType = parsed["user_type"].toString();
//       globals.companyname = parsed["company_name"].toString();
//       globals.companyPhone = parsed["cell_no"].toString();
//       globals.companyEmail = parsed["company_email"].toString();
//       globals.companyAdress = parsed["address"].toString();
//       globals.companyDesign = 0;
//       // int.parse((parsed["invoice_header_no"] ?? "0").toString());
//       globals.logoBase64 = parsed["logo_pic"].toString();
//       globals.isInclusive = parsed["sale_tax_ex_inclusive"].toString() == "false" ? false : true;
//       globals.currencyUnitId = int.parse((parsed["currency_units_id"] ?? "0").toString());
//       if (parsed["package_type"] == "Free") {
//         packageTypeTrail = true;
//       }

//       // logEvent("LoginOnCounty", {
//       //   'company': parsed["company_name"].toString(),
//       //   'loginId': parsed["login_id"].toString(),
//       //   'userName': parsed["username"].toString(),
//       // });

//       if (parsed["status"] == false || parsed["status"].toString() == "false") {
//         if (parsed["package_type"] == null || parsed["package_type"] == "") {
//           globals.isFirstpurchase = true;
//         }
//         // AutoRouter.of(context).push(DashboardRoute());
//         GNav.pushNav(context, RouteConfig.dashboardRoute);
//         // Modular.to.pushNamed("/Dashboard");
//         // Modular.to.pushNamed("/PaymentPending");
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => PendingPayment()));
//       } else {
//         // if (parsed["role_name"] == "Essentials") {
//         //   globals.isEssential = true;
//         // }

//         // AutoRouter.of(context).push(DashboardRoute());
//         GNav.pushNav(context, RouteConfig.dashboardRoute);

//         // Modular.to.pushNamed("/Dashboard");
//       }
//     } else {
//       gLogger("Not registered");
//     }
//   }

//   Widget _submitButton() {
//     return InkWell(
//         onTap: () {
//           // _showMyDialogLoader("");
//           if (_formKey.currentState!.validate()) {
//             loginCustomer();
//           }

//           // Navigator.push(
//           //     context, MaterialPageRoute(builder: (context) => DashBoard()));
//         },
//         child: Container(
//           //  margin: EdgeInsets.symmetric(horizontal: 40),
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.symmetric(vertical: 15),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//             boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
//             color: mainColorPrimary,
//           ),
//           child: Text(
//             T("Signup"),
//             style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
//           ),
//         ));
//   }

//   Widget _submitButtonProcess() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(vertical: 10),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//         boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
//         color: mainColorPrimary,
//       ),
//       child: SpinKitThreeBounce(
//         color: mainColorSecondry,
//         size: 30,
//       ),
//     );
//   }

//   LocalAuthentication auth = LocalAuthentication();
//   bool? _canCheckBiometric;
//   List<BiometricType>? _availableBiometric;
//   String authorized = "Not authorized";

//   //checking bimetrics
//   //this function will check the sensors and will tell us
//   // if we can use them or not
//   Future<void> _checkBiometric() async {
//     bool? canCheckBiometric;
//     try {
//       canCheckBiometric = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       gLogger(e);
//     }
//     if (!mounted) return;

//     setState(() {
//       _canCheckBiometric = canCheckBiometric;
//     });
//   }

//   //this function will get all the available biometrics inside our device
//   //it will return a list of objects, but for our example it will only
//   //return the fingerprint biometric
//   Future<void> _getAvailableBiometrics() async {
//     List<BiometricType>? availableBiometric;
//     try {
//       availableBiometric = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       gLogger(e);
//     }
//     if (!mounted) return;

//     setState(() {
//       _availableBiometric = availableBiometric;
//     });
//   }

//   //this function will open an authentication dialog
//   // and it will check if we are authenticated or not
//   // so we will add the major action here like moving to another activity
//   // or just display a text that will tell us that we are authenticated
//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: T("login_Scan_your_finger"),
//         // useErrorDialogs: true,
//         // stickyAuth: false
//       );
//     } on PlatformException catch (e) {
//       gLogger(e);
//     }
//     if (!mounted) return;
//     if (authenticated) {
//       loginCustomerBioMetric();
//     }

//     setState(() {
//       authorized = authenticated ? "Autherized success" : "Failed to authenticate";
//     });
//   }

//   bool isSwitched = false;
//   Widget _biometricButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Row(
//                 children: [
//                   // IconButton(
//                   //   icon: Icon(Icons.fingerprint),

//                   //   iconSize: 40,
//                   //   color: mainColorPrimary,
//                   // ),
//                   InkWell(
//                     child: Text(
//                       T(
//                         "login_Biometric_Login",
//                       ),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     onTap: (() {
//                       onPressed:
//                       () {
//                         if (isSwitched) {
//                           SharedPreferences.getInstance().then((prefs) {
//                             if (prefs.getStringList('loginDetailsBiometric') != null && prefs.getStringList('loginDetailsBiometric')!.length > 0) {
//                               List temp = prefs.getStringList('loginDetailsBiometric')!;
//                               usernmae = temp[0];
//                               password = temp[1];
//                               _authenticate();
//                             } else {
//                               // showDialog(
//                               //     context: context,
//                               //     builder: (context) {
//                               //       return CustomDialog(
//                               //         title: "Genial365",
//                               //         content: "",
//                               //         positiveBtnText: "Done",
//                               //         negativeBtnText: "Cancel",
//                               //         widget: Text(
//                               //             "Please login using your username and Password for the first time to enable the biometric login."),
//                               //         positiveBtnPressed: () {
//                               //           // Do something here
//                               //           Navigator.of(context).pop();
//                               //         },
//                               //         widgetButton: TextButton(
//                               //             onPressed: () {
//                               //               Navigator.pop(context);
//                               //             },
//                               //             child: Text("Ok")),

//                               //         // widget: Text("Hello"),
//                               //       );
//                               //    });
//                             }
//                           });
//                         }

//                         // SharedPreferences.getInstance().then((prefs) {
//                         //   if (prefs.getStringList('loginDetails') != null &&
//                         //       prefs.getStringList('loginDetails')!.length > 0) {
//                         //     List<String>? temp =
//                         //         prefs.getStringList('loginDetails');
//                         //     usernmae = temp![0];
//                         //     password = temp[1];
//                         //     loginCustomerBioMetric();
//                         //   }
//                         // });
//                       };
//                     }),
//                   )
//                 ],
//               ),
//               Switch(
//                 onChanged: (value) {
//                   if (value) {
//                     // showDialog(
//                     //     context: context,
//                     //     builder: (context) {
//                     //       return CustomDialog(
//                     //         title: "Genial365",
//                     //         content: "",
//                     //         positiveBtnText: "Done",
//                     //         negativeBtnText: "Cancel",
//                     //         widget: Text(
//                     //             "Please login using your username and Password for the first time to enable the biometric login."),
//                     //         positiveBtnPressed: () {
//                     //           // Do something here
//                     //           Navigator.of(context).pop();
//                     //         },
//                     //         widgetButton: TextButton(
//                     //             onPressed: () {
//                     //               Navigator.pop(context);
//                     //             },
//                     //             child: Text("Ok")),
//                     //       );
//                     //     });
//                     // setState(() {
//                     //   isSwitched = value;
//                     // });
//                   } else {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Text(T("login_County")),
//                             content: Text(T("login_You_would_need_to_enter_your_username"), style: GoogleFonts.poppins(fontSize: 13)),
//                             actions: <Widget>[
//                               TextButton(
//                                 // color: mainColorPrimary,
//                                 // textColor: Colors.white,
//                                 // disabledColor: Colors.grey,
//                                 // disabledTextColor: Colors.black,
//                                 // padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                                 // splashColor: Colors.greenAccent,
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: mainColorPrimary,
//                                   disabledBackgroundColor: Colors.grey,
//                                   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   T("login_No"),
//                                   style: GoogleFonts.poppins(color: Colors.black),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                               TextButton(
//                                 // color: mainColorPrimary,
//                                 // textColor: Colors.white,
//                                 // disabledColor: Colors.grey,
//                                 // disabledTextColor: Colors.black,
//                                 // padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                                 // splashColor: Colors.greenAccent,
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: mainColorPrimary,
//                                   disabledBackgroundColor: Colors.grey,
//                                   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   T("login_Yes"),
//                                   style: GoogleFonts.poppins(color: Colors.black),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                   SharedPreferences.getInstance().then((prefs) {
//                                     prefs.setBool('biometricEnable', false);
//                                     prefs.setStringList('loginDetailsBiometric', []);
//                                   });
//                                   setState(() {
//                                     isSwitched = false;
//                                   });
//                                 },
//                               )
//                             ],
//                           );
//                         });
//                   }
//                 },
//                 value: isSwitched,
//                 activeColor: mainColorPrimary,
//                 activeTrackColor: mainColorPrimaryYellow,
//                 inactiveThumbColor: Colors.grey,
//                 inactiveTrackColor: mainColorPrimaryYellow,
//               )
//               // Container(
//               //   // width: MediaQuery.of(context).size.width,
//               //   padding: EdgeInsets.symmetric(vertical: 15),
//               //   alignment: Alignment.center,
//               //   decoration: BoxDecoration(
//               //       borderRadius: BorderRadius.all(Radius.circular(5)),
//               //       boxShadow: <BoxShadow>[
//               //         BoxShadow(
//               //             color: Colors.grey.shade200,
//               //             offset: Offset(2, 4),
//               //             blurRadius: 5,
//               //             spreadRadius: 2)
//               //       ],
//               //       gradient: LinearGradient(
//               //           begin: Alignment.centerLeft,
//               //           end: Alignment.centerRight,
//               //           colors: [Color(0xfffadd13), mainColorPrimary])),
//               //   child: Text(
//               //     'Login',
//               //     style: AppStyle.style20w600(color: Colors.white),
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _divider() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             width: 20,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Divider(
//                 thickness: 1,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _facebookButton() {
//     return Container(
//       height: 50,
//       margin: EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xff4285f4),
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
//               ),
//               alignment: Alignment.center,
//               child: Text(T("login_G"), style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400)),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xff34a853),
//                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
//               ),
//               alignment: Alignment.center,
//               child: TextHeading4(
//                 T("login_Log_in_with_Google"),
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _launchURL(String url) async => await canLaunch(url)
//       ? await launch(
//           url,
//           forceSafariVC: true,
//           forceWebView: true,
//           webOnlyWindowName: '_self',
//         )
//       : throw 'Could not launch $url';
//   Widget _createAccountLabel() {
//     return InkWell(
//       onTap: () {
//         // logEvent("ClickOnRegister", {});
//         if (UniversalPlatform.isIOS) {
//           String _url = "";
//           if (referralCode != "" && referralCode != null) {
//             _url = "https://genial365.com/register?referralCode=$referralCode";
//           } else {
//             _url = "https://county.genial365.com/#/SubscriptionPlans";
//           }

//           _launchURL(_url);
//         } else {
//           globals.isFirstpurchase = true;
//           Modular.to.pushNamed("/Pricing");
//           // Modular.to.pushNamed("/SubscriptionPlans");
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10),
//         padding: EdgeInsets.all(15),
//         alignment: Alignment.bottomCenter,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               T("login_Dont_have_an_account"),
//               style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               T("login_Register"),
//               style: TextStyle(color: mainColorPrimaryYellow, fontSize: 13, fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _title() {
//     // double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         const Image(
//           image: AssetImage('assets/imgs/logo2.png'),
//           width: 90,
//           height: 90,
//         ),
//         SizedBox(
//           height: h * 0.005,
//           // height: 15,
//         ),
//         Text(
//           T('login_Login_to_your_Account'),
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         SizedBox(
//           height: h * 0.005,
//           // height: 10,
//         ),
//         Text(
//           T('login_Please_enter_your_username_and_password'),
//           style: TextStyle(fontSize: 14, color: Color(0xff89999F)),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: h * 0.015,
//           ),
//           child: InkWell(
//             onTap: () {
//               // ///-----changes here
//               //
//               // Timer(const Duration(seconds: 1), () {
//               //   MyToast.success(
//               //       "Account Updated Succssfully, ");
//               //     Timer(const Duration(seconds: 3), () {
//               //       MyToast.error(
//               //           "Account Updated Succssfully, ");
//               //       Timer(const Duration(seconds: 3), () {
//               //         MyToast.info(
//               //             "Account Updated Succssfully, ");
//               //         Timer(const Duration(seconds: 3), () {
//               //           MyToast.warning(
//               //               "Account Updated Succssfully, ");
//               //         });
//               //       });
//               //     });
//               // });

//               setState(() {
//                 if (checkedValueEmailLogin) {
//                   checkedValueEmailLogin = false;
//                 } else {
//                   checkedValueEmailLogin = true;
//                 }
//                 //   checkedValuePhoneLogin = false;
//               });
//             },
//             child: RichText(
//               text: TextSpan(
//                 text: '------------',
//                 style: const TextStyle(color: Color(0xffE2EBED), fontWeight: FontWeight.bold),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: (!checkedValueEmailLogin ? T('Login_Sign_in_with_Email') : T('Login_Sign_in_with_Phone_No')),
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: secondaryColorOrange)),
//                   const TextSpan(
//                     text: '------------',
//                     style: TextStyle(color: Color(0xffE2EBED), fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   bool checkedValue = false;
//   final _formKey = GlobalKey<FormState>();
//   var maskFormatter = MaskTextInputFormatter(mask: '*##-#######', filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[1-9]')});
//   TextEditingController _controllerPhoneNoCountryCode = new TextEditingController(text: "+92");
//   bool passwordVisible = true;
//   bool checkedValueEmailLogin = false;
//   // bool checkedValuePhoneLogin = true;
//   String phoneNumber = "";
//   Widget _emailPasswordWidget() {
//     return Column(
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 50),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: const [
//                   // Checkbox(
//                   //     value: checkedValueEmailLogin,
//                   //     onChanged: (value) {
//                   //       setState(() {
//                   //         checkedValueEmailLogin =
//                   //             value != null ? value : false;
//                   //       });
//                   //     }),
//                   // Text(T("login_Email")),
//                 ]),
//                 if (checkedValueEmailLogin)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         T('login_Email'),
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       MyTextFormField(
//                         controller: controllerEmail,
//                         // isAddTopMargin: false,
//                         // labelText: T("login_Email"),
//                         hintText: T("login_Enter_Email"),
//                         validator: (value) {
//                           if (!validator.isEmail(value.toString())) {
//                             return T("login_Please_enter_a_valid_email");
//                           }
//                           _formKey.currentState!.save();
//                           return null;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 28,
//                       ),
//                     ],
//                   ),

//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Container(
//                 //       width: 70,
//                 //       child: Column(
//                 //         mainAxisAlignment: MainAxisAlignment.center,
//                 //         crossAxisAlignment: CrossAxisAlignment.center,
//                 //         children: [
//                 //           MyTextFormField(
//                 //             controller: _controllerPhoneNoCountryCode,
//                 //             isEnabled: false,
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ),
//                 //     Expanded(
//                 //       child: MyTextFormFieldFormated(
//                 //         controller: controllerusernmae,
//                 //         inputFormatters: maskFormatter,
//                 //         isEnabled: !loogingIn,
//                 //         labelText: T("login_phoneno"),
//                 //         hintText: '331-1234567',
//                 // validator: (value) {
//                 //   if (value.length != 11) {
//                 //     return T("login_Please_enter_10_digit_phone_no");
//                 //   }
//                 //   return null;
//                 // },
//                 //         onSaved: (value) {},
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 Column(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (!checkedValueEmailLogin)
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             T('login_phoneno'),
//                             style: TextStyle(fontWeight: FontWeight.w700),
//                           ),
//                           const SizedBox(
//                             height: 6,
//                           ),
//                           IntlPhoneField(
//                             controller: controllerusernmae,
//                             showDropdownIcon: false,
//                             // countries: ["Pakistan"],
//                             // textAlign: TextAlign.left,
//                             // dropdownIconPosition: IconPosition.trailing,
//                             //  inputFormatters: [maskFormatter],
//                             flagsButtonPadding: EdgeInsets.only(left: 5, right: 5),
//                             decoration: InputDecoration(
//                               //  labelText: 'Phone Number',

//                               // contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                               hintText: '3311234567',
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(),
//                               ),
//                             ),

//                             validator: (value) {
//                               if (value!.number.length != 11) {
//                                 return T("login_Please_enter_10_digit_phone_no");
//                               }
//                               return null;
//                             },
//                             initialCountryCode: 'PK',
//                             onChanged: (phone) {
//                               gLogger(phone.completeNumber);
//                               setState(() {
//                                 phoneNumber = phone.completeNumber;
//                               });
//                             },
//                             onCountryChanged: (country) {
//                               gLogger('Country changed to: ' + country.name);
//                             },
//                             onSaved: (value) {},
//                           ),
//                         ],
//                       ),
//                     Text(
//                       T('Login_Password'),
//                       style: TextStyle(fontWeight: FontWeight.w700),
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     MyTextFormField(
//                       controller: controllerpassword,
//                       // labelText: T("login_Password"),
//                       hintText: T("login_Password"),
//                       // isAddTopMargin: false,
//                       isEnabled: !loogingIn,
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           // Based on passwordVisible state choose the icon
//                           passwordVisible ? Icons.visibility : Icons.visibility_off,
//                           color: Colors.green,
//                         ),
//                         onPressed: () {
//                           // Update the state i.e. toogle the state of passwordVisible variable
//                           setState(() {
//                             passwordVisible = !passwordVisible;
//                           });
//                         },
//                       ),
//                       isPassword: passwordVisible,
//                       onFieldSubmitted: (value) {
//                         if (_formKey.currentState!.validate()) {
//                           loginCustomer();
//                         }
//                       },
//                       validator: (value) {
//                         if (value.length < 2) {
//                           return T("login_Password_should_be_minimum");
//                         }

//                         _formKey.currentState!.save();

//                         return null;
//                       },
//                     ),
//                   ],
//                 ),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 8.0, right: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Checkbox(
//                                 value: checkedValue,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     checkedValue = !checkedValue;
//                                   });
//                                 },
//                               ),
//                               InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       checkedValue = !checkedValue;
//                                     });
//                                   },
//                                   child: Text(
//                                     T("login_Remember_Me"),
//                                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: Responsive.isMobile(context) ? 10 : 14),
//                                   )),
//                             ],
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
//                           },
//                           child: Text(T("login_Forgot_Password"),
//                               textAlign: TextAlign.right,
//                               style: TextStyle(
//                                   //  decoration: TextDecoration.underline,
//                                   color: secondaryColorOrange,
//                                   fontSize: Responsive.isMobile(context) ? 10 : 14)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 (!loogingIn) ? _submitButton() : _submitButtonProcess(),

// // //                       Container(
// //                         height: 42,
// //                         width: ScreenUtil.getWidth(context),
// //                         margin: EdgeInsets.only(top: 32, bottom: 12),
// //                         child: ShadowButton(
// //                           borderRadius: 12,
// //                           height: 40,
// //                           child: FlatButton(
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: new BorderRadius.circular(8.0),
// //                             ),
// //                             color: themeColor.getColorGreen(),
// //                             onPressed: () {
// //                               if (_formKey.currentState.validate()) {
// //                                 _formKey.currentState.save();
// //                                 loginCustomer(pr);
// // //                      Navigator.push(
// // //                          context,
// // //                          MaterialPageRoute(
// //                                 //  builder: (context) => Result(model: this.model)));
// //                               }
// //                               //   Nav.routeReplacement(context, InitPage());
// //                             },
// //                             child: Text(
// //                               'Sign In',
// //                               style: GoogleFonts.poppins(
// //                                 fontSize: 16,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.w400,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
//               ],
//             ),
//           ),
//         ),

//         // _entryField("Email id", controllerusernmae),
//         // _entryField("Password", controllerpassword, isPassword: true),
//       ],
//     );
//   }

//   Future<bool> _onBackPressed() {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: new Text(T("login_Are_you_sure")),
//         content: new Text(T("login_Do_you_want_to_exit")),
//         actions: <Widget>[
//           new GestureDetector(
//             onTap: () => Navigator.of(context).pop(false),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Text(T("login_No")),
//             ),
//           ),
//           SizedBox(height: 16),
//           new GestureDetector(
//             onTap: () => SystemNavigator.pop(),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Text(T("login_Yes")),
//             ),
//           ),
//         ],
//       ),
//     ).then((value) => value as bool);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: WillPopScope(
//             onWillPop: () async => true,
//             child: Scaffold(
//               backgroundColor: const Color(0xff003A4D),
//               body: Responsive.isBigDesktopDesktop(context) || Responsive.isDesktop(context)
//                   ? Stack(
//                       children: [
//                         Image(
//                             image: const AssetImage(
//                               'assets/imgs/bg-login.png',
//                             ),
//                             // height: double.infinity,
//                             width: width,
//                             height: height,
//                             fit: BoxFit.cover),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // We want this side menu only for large screen
//                             // if (Responsive.isDesktop(context))
//                             //   Expanded(
//                             //     flex: 1,
//                             //     // and it takes 1/6 part of the screen
//                             //     child: Container(
//                             //       color: Colors.transparent,
//                             //     ),
//                             //   ),
//                             Expanded(
//                               // It takes 5/6 part of the screen
//                               flex: 16,
//                               child: Container(
//                                   margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.11, horizontal: MediaQuery.of(context).size.width * 0.11),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Colors.white,
//                                   ),
//                                   child: Container(
//                                       height: height,
//                                       child: Row(
//                                         // crossAxisAlignment:
//                                         //     CrossAxisAlignment.center,
//                                         // mainAxisAlignment:
//                                         //     MainAxisAlignment.center,
//                                         children: [
//                                           Responsive.isBigDesktopDesktop(context) || Responsive.isDesktop(context)
//                                               ? Expanded(
//                                                   flex: 4,
//                                                   child: Container(
//                                                     // color: Colors.yellow,
//                                                     margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
//                                                     child: const Image(image: AssetImage("assets/imgs/login-left-Image.png")),
//                                                   ),
//                                                 )
//                                               : const SizedBox.shrink(),
//                                           Expanded(
//                                             flex: 5,
//                                             child: Stack(
//                                               alignment: Alignment.center,
//                                               children: <Widget>[
//                                                 const Positioned(
//                                                     // top: -height * .15,
//                                                     // right:
//                                                     //     -MediaQuery.of(context).size.width * .4,
//                                                     child: BezierContainer()),
//                                                 if (!kIsWeb) _biometricButton(),
//                                                 SingleChildScrollView(
//                                                   child: Column(
//                                                     // mainAxisSize:
//                                                     //     MainAxisSize.max,
//                                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: <Widget>[
//                                                       // SizedBox(
//                                                       //     height:
//                                                       //         height * .05),
//                                                       _title(),
//                                                       // Center(
//                                                       //   child: RaisedButton(
//                                                       //     onPressed: _authenticate,
//                                                       //     child: Text("Get Biometric"),
//                                                       //   ),
//                                                       // ),
//                                                       // Text("Can check biometric: $_canCheckBiometric"),
//                                                       // Text("Available biometric: $_availableBiometric"),
//                                                       // Text("Current State: $authorized"),
//                                                       // SizedBox(height: 30),
//                                                       _emailPasswordWidget(),
//                                                       // FadeAnimation(1.1, _emailPasswordWidget()),
//                                                       // SizedBox(height: 20),
//                                                       // (!loogingIn)
//                                                       //     ? _submitButton()
//                                                       //     : _submitButtonProcess(),

//                                                       // FadeAnimation(1.2, _submitButton()),
//                                                       // FadeAnimation(1.4, _biometricButton()),
//                                                       // _divider(),
//                                                       // IconButton(
//                                                       //     onPressed: () {
//                                                       //       if (EasyLocalization.of(
//                                                       //                   context)!
//                                                       //               .locale ==
//                                                       //           Locale("en")) {
//                                                       //         EasyLocalization.of(
//                                                       //                 context)!
//                                                       //             .setLocale(
//                                                       //                 Locale(
//                                                       //                     "ur"));
//                                                       //       } else {
//                                                       //         EasyLocalization.of(
//                                                       //                 context)!
//                                                       //             .setLocale(
//                                                       //                 Locale(
//                                                       //                     'en'));
//                                                       //       }
//                                                       //     },
//                                                       //     icon: Icon(
//                                                       //         Icons.language)),
//                                                       // FadeAnimation(1.5, _divider()),
//                                                       // FadeAnimation(
//                                                       //   1.5,
//                                                       //   _facebookButton(),
//                                                       // ),
//                                                       //

//                                                       if (!UniversalPlatform.isIOS) _createAccountLabel(),
//                                                       // SizedBox(height: 40),
//                                                       // if (isdev)
//                                                       //   Text(
//                                                       //     T("login_App_version_Dev"),
//                                                       //     style:
//                                                       //         GoogleFonts.poppins(
//                                                       //             color: textColor),
//                                                       //   )
//                                                       // FadeAnimation(
//                                                       //   1.6,
//                                                       //   _createAccountLabel(),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ))),
//                             ),

//                             // if (Responsive.isDesktop(context))
//                             //   Expanded(
//                             //     flex: 1,
//                             //     // default flex = 1
//                             //     // and it takes 1/6 part of the screen
//                             //     child: Container(),
//                             //   ),
//                           ],
//                         ),
//                         Responsive.isBigDesktopDesktop(context) || Responsive.isDesktop(context)
//                             ? Positioned.fill(
//                                 bottom: 40,
//                                 //  right: 650,
//                                 child: Align(
//                                   alignment: Alignment.bottomCenter,
//                                   // mainAxisAlignment: MainAxisAlignment.center,
//                                   // crossAxisAlignment: CrossAxisAlignment.center,
//                                   child: InkWell(
//                                     onTap: () {
//                                       Modular.to.pushNamed("/Dashboard");
//                                     },
//                                     child: Text(
//                                       T("login_App_version_Dev"),
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.poppins(color: whiteColor),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : SizedBox.shrink(),
//                         Text(" "),
//                         Positioned(
//                             bottom: 20,
//                             right: 20,
//                             child: Image(
//                               image: AssetImage('assets/imgs/poweredbyicon.png'),
//                             ))
//                       ],
//                     )
//                   : Scaffold(
//                       backgroundColor: Colors.white,
//                       body: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             if (!kIsWeb) _biometricButton(),
//                             SizedBox(height: height * .1),
//                             _title(),
//                             // Center(
//                             //   child: RaisedButton(
//                             //     onPressed: _authenticate,
//                             //     child: Text("Get Biometric"),
//                             //   ),
//                             // ),
//                             // Text("Can check biometric: $_canCheckBiometric"),
//                             // Text("Available biometric: $_availableBiometric"),
//                             // Text("Current State: $authorized"),
//                             // SizedBox(height: 30),
//                             _emailPasswordWidget(),
//                             // FadeAnimation(1.1, _emailPasswordWidget()),
//                             // SizedBox(height: 20),
//                             // (!loogingIn)
//                             //     ? _submitButton()
//                             //     : _submitButtonProcess(),

//                             // FadeAnimation(1.2, _submitButton()),
//                             // FadeAnimation(1.4, _biometricButton()),
//                             // _divider(),
//                             // IconButton(
//                             //     onPressed: () {
//                             //       if (EasyLocalization.of(
//                             //                   context)!
//                             //               .locale ==
//                             //           Locale("en")) {
//                             //         EasyLocalization.of(
//                             //                 context)!
//                             //             .setLocale(
//                             //                 Locale("ur"));
//                             //       } else {
//                             //         EasyLocalization.of(
//                             //                 context)!
//                             //             .setLocale(
//                             //                 Locale('en'));
//                             //       }
//                             //     },
//                             //     icon:
//                             //         Icon(Icons.language)),
//                             // FadeAnimation(1.5, _divider()),
//                             // FadeAnimation(
//                             //   1.5,
//                             //   _facebookButton(),
//                             // ),
//                             //

//                             if (!UniversalPlatform.isIOS) _createAccountLabel(),
//                             // SizedBox(height: 40),
//                             // if (isdev)
//                             //   Text(
//                             //     T("login_App_version_Dev"),
//                             //     style:
//                             //         GoogleFonts.poppins(
//                             //             color: textColor),
//                             //   )
//                             // FadeAnimation(
//                             //   1.6,
//                             //   _createAccountLabel(),
//                           ],
//                         ),
//                       ),
//                     ),
//             )));
//   }
// }
