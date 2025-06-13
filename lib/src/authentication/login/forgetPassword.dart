// import 'dart:convert';
// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:global365books/Languages/Languages.dart';
// import 'package:global365books/Services/ResponseModel/resonse_model.dart';
// import 'package:global365books/Services/get_request.dart';
// import 'package:global365books/Services/post_requests.dart';
// import 'package:global365books/core/app_export.dart';
// import 'package:global365books/core/constants/globals.dart' as globals;
// import 'package:global365books/theme/Text/TextVariants/text_heading2.dart';
// import 'package:global365books/theme/Text/TextVariants/text_heading4.dart';
// import 'package:global365books/theme/Text/TextVariants/text_heading5.dart';
// import 'package:global365books/theme/text_style.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../Widgets/RaisedGradienButton.dart';
// import '../../Widgets/bezierContainer.dart';
// import '../../Widgets/custom_textfield.dart';
// import '../../Widgets/custom_textfieldformated.dart';
// import '../../Widgets/progressDialog.dart';
// import 'loginPage.dart';

// class ForgetPassword extends StatefulWidget {
//   ForgetPassword({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _ForgetPasswordState createState() => _ForgetPasswordState();
// }

// class _ForgetPasswordState extends State<ForgetPassword> {
//   String bussinesType = "";
//   List<dynamic> acc_lsit = [
//     {'name': 'farooq', 'checkValue': false, 'paid': '', 'expense': ''},
//     {'name': 'Hamza', 'checkValue': false},
//     {'name': 'Umer', 'checkValue': false, 'paid': '', 'expense': ''}
//   ];

//   dynamic jsonArrayStockUnit = [];

//   List<String> list_bussiness = ["AOP", "Individual"];
//   String countryId = "";
//   List<String> list_country = ["Pakistan", "India", "USA"];
//   String cityName = "";
//   List<String> list_cityname = ["Faisalabad", "Lahore", "Karachi"];
//   String currancy = "";
//   List<String> list_currancy = ["RS", "RS", "Dollar"];
//   TextEditingController _controllerEmail = new TextEditingController();
//   TextEditingController _controllerVerifyCode = new TextEditingController();
//   TextEditingController _controllerPassword = new TextEditingController();
//   TextEditingController _controllerConfirmPassword = new TextEditingController();
//   bool _validatorEmail = false;
//   bool _validatorVerifyCode = false;
//   bool _validatorPassword = false;
//   bool _validatorPasswordConfirm = false;
//   String errorText = T("forg_This_field_can_not_be_empty");

//   int? group1;
//   String btnText = T("forg_Add_Stock_Unit");
//   bool flag_btnType = false;
//   String _loginId = "";
//   bool _validateStockUnit = false;

//   @override
//   void initState() {
//     // fetchData();
//     super.initState();
//     group1 = 0;
//     setState(() {});
//   }

//   setSelectedRadio(int val) {
//     setState(() {
//       group1 = val;
//     });
//   }

//   Future<void> _addStockUnit(String stockUnit) async {
//     ProgressDialogCustom(context).show();
//     ResponseModel response = await APIsCallPost.submitRequestWithOutBody("requestUrl");
//     // await PostAPICall.postwithauth(context, APIs.apistock_units,
//     //     {"stock_units_id": 0, "stock_unit_name": stockUnit, "autodatetime": "2020-12-03T08:48:07.481Z", "login_id": globals.loginId});
//     if (response.statusCode == 201) {
//       ProgressDialogCustom(context).hide();
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showSuccess(T("forg_Added_Succesfully"));
//       fetchData();
//       controllerstockUnit.clear();

//       gLogger(response.data.toString());
//     } else {
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showError(T("forg_Some_error_in_adding_stock_unit"));
//     }
//   }

//   // Future<void> deleteAlbum(String id) async {
//   //   EasyLoading.show(
//   //     status: 'Deleteing...',
//   //   );
//   //   final http.Response response = await http.delete(
//   //      globals.apiLink+'api/bank_names/$id',
//   //     headers: <String, String>{
//   //       'Content-Type': 'application/json; charset=UTF-8',
//   //     },
//   //   );

//   //   if (response.statusCode == 200) {
//   //     fetchData();
//   //   } else {}
//   // }

//   Future<void> _updateStock(
//     String id,
//     String stockName,
//   ) async {
//     EasyLoading.show(
//       status: T("forg_Updating"),
//     );
//     final http.Response response = await http.put(
//       Uri.parse(globals.apiLink + 'api/stock_units/$id'),
//       headers: <String, String>{
//         'Accept': 'application/json',
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': globals.tokenType + " " + globals.accessToken
//       },
//       body: jsonEncode(<String, dynamic>{"stock_units_id": 0, "stock_unit_name": stockName, "autodatetime": "2020-12-03T08:48:08.481Z", "login_id": globals.loginId}),
//     );
//     gLogger(response.statusCode.toString());
//     if (response.statusCode == 200 || response.statusCode == 204) {
//       ProgressDialogCustom(context).hide();
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showSuccess(T("forg_Successfully_Updated"));
//       Future.delayed(const Duration(milliseconds: 500), () {
//         fetchData();
//         controllerstockUnit.clear();

//         setState(() {
//           flag_btnType = false;
//         });
//       });
//     } else {
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showError(T("bank_Some_error_occured_in_updateing_the_info"));
//     }
//   }

//   Future<void> fetchData() async {
//     ProgressDialogCustom(context).show();
//     ResponseModel response = await APIsCallGet.getData("requestUrl");
//     // await GetAPICall.getwithauth(context, APIs.apistock_units + '?login_id=' + globals.loginId);

//     if (response.statusCode == 200) {
//       ProgressDialogCustom(context).hide();
//       dynamic tempArray = [];
//       // Navigator.push(
//       gLogger('success');

//       final parsed = jsonDecode(response.data).cast<Map<String, dynamic>>();

//       String stockId = "";
//       String stockName = "";

//       for (Map i in parsed) {
//         i.forEach((key, value) {
//           if (key == "stock_units_id") {
//             stockId = value.toString();

//             // bankId = "";
//           }
//           if (key == "stock_unit_name") {
//             stockName = value.toString();
//           }
//         });
//         setState(() {
//           tempArray.add({
//             "stockId": stockId,
//             "stockUnit": stockName,
//           });
//         });

//         gLogger(i.toString());
//       }
//       gLogger(jsonArrayStockUnit.toString());
//       setState(() {
//         jsonArrayStockUnit = tempArray;
//       });

//       gLogger(jsonArrayStockUnit.toString());
//     } else {
//       ProgressDialogCustom(context).hide();
//       gLogger('error');
//     }
//   }

//   // Future<void> _showMyDialog(String message) async {
//   //   return showDialog<void>(
//   //     context: context,
//   //     barrierDismissible: false, // user must tap button!
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text(globalapplicationName + ' says:'),
//   //         content: SingleChildScrollView(
//   //           child: ListBody(
//   //             children: <Widget>[
//   //               Text(message),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: <Widget>[
//   //           Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: RaisedButton(
//   //               color: Color(globals.colorCodeYellow),
//   //               child: Text(
//   //                 'Ok',
//   //                 style: TextStyle(color: Color(globals.colorCodeGreen)),
//   //               ),
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //               },
//   //             ),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   TextEditingController controllerstockUnit = new TextEditingController();

//   Widget _backButton() {
//     return InkWell(
//       onTap: () {
//         if (_flag == 0) {
//           if (!kIsWeb) {
//             Modular.to.popUntil(ModalRoute.withName("/"));
//           } else {
//             Navigator.pop(context);
//           }

//           // Navigator.of(context).pushAndRemoveUntil(
//           //     MaterialPageRoute(builder: (context) => LoginPage()),
//           //     (Route<dynamic> route) => false);
//           // Navigator.pop(context);
//         } else if (_flag == 1) {
//           setState(() {
//             _flag = 0;
//           });
//         } else if (_flag == 2) {
//           setState(() {
//             _flag = 1;
//           });
//         }
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

//   Widget _entryField(String title, String hint, TextEditingController txtController, bool _validate, {bool isPassword = false}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 2),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextHeading5(
//             title,
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           TextField(
//             obscureText: isPassword,
//             controller: txtController,
//             onChanged: (value) {
//               setState(() {
//                 errorText = T("forg_This_field_can_not_be_empty");
//                 if (title == "Email:") {
//                   _validatorEmail = false;
//                 } else if (title == "Verification Code:") {
//                   _validatorVerifyCode = false;
//                 } else if (title == "Password:") {
//                   _validatorPassword = false;
//                 } else if (title == "Confirm Password:") {
//                   _validatorPasswordConfirm = false;
//                 }
//               });
//             },
//             decoration: InputDecoration(
//               hintText: hint,
//               contentPadding: EdgeInsets.all(15.0),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(
//                   width: 1,
//                   style: BorderStyle.none,
//                 ),
//               ),
//               labelText: title,
//               filled: true,
//               fillColor: Color(0xFFEEEEF3),
//             ),
//             // decoration: InputDecoration(
//             //     border: InputBorder.none,
//             //     fillColor: Color(0xfff3f3f4),
//             //     hintText: hint,
//             //     errorText: _validate ? errorText : null,
//             //     filled: true),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _title2() {
//     return TextHeading2(T("forg_Reset_Password"), color: mainColorPrimary);
//   }

//   // Widget _dropDownFiled() {
//   //   return DropDownField(
//   //     onValueChanged: (dynamic value) {
//   //       countryId = value;
//   //     },
//   //     value: countryId,
//   //     required: false,
//   //     hintText: "Select Country",
//   //     items: list_country,
//   //   );
//   // }

//   Future<void> _updatePasswordApi() async {
//     ResponseModel response = await APIsCallPost.submitRequestWithOutBody("requestUrl");
//     // await PostAPICall.postwithauth(context, APIs.apiForgotPassword, {"newpassword": _controllerPassword.text, "login_id": _loginId});

//     gLogger(_loginId.toString() + response.statusCode.toString());
//     if (response.statusCode == 200) {
//       ProgressDialogCustom(context).hide();
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showSuccess(T("forg_Password_has_been_updated_Successfully"));
//       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

//       gLogger(response.data.toString());
//     } else {
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showError(T("login_Some_error_in_sending_link"));
//     }
//   }

//   Future<void> _sendVerifyLink() async {
//     EasyLoading.show(
//       status: T("login_Sending_Mail"),
//     );
//     ResponseModel response = await APIsCallPost.submitRequestWithOutBody("requestUrl");
//     //  await PostAPICall.postwithauth(
//     //     context, APIs.apiEmailVerify, {"user_email": _controllerEmail.text});

//     if (response.statusCode == 200) {
//       ProgressDialogCustom(context).hide();
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showSuccess(T("forg_Code_has_been_sent_to_your_email_address"));

//       gLogger(response.data.toString());
//     } else {
//       ProgressDialogCustom(context).hide();
//       EasyLoading.showError(T("forg_Some_error_in_sending_link"));
//     }
//   }

//   var rng = new Random();
//   int next(int min, int max) => min + rng.nextInt(max - min);
//   Future<void> _sendCodeAPI() async {
//     ResponseModel response = await APIsCallPost.submitRequestWithOutBody("requestUrl");
//     // await PostAPICall.postwithauth(
//     //     context,
//     //     APIs.apiCheckUserExsit,
//     //     {"user_email": "92" + maskFormatter.getUnmaskedText()});

//     if (response.statusCode == 200) {
//       final parsed = jsonDecode(response.data).cast<Map<String, dynamic>>();

//       String loginId = "";
//       String bankName = "";
//       String bankBranchName = "";

//       for (Map i in parsed) {
//         i.forEach((key, value) {
//           if (key == "login_id") {
//             loginId = value.toString();
//           }
//         });
//       }
//       _loginId = loginId;
//       setState(() {
//         _flag = 1;
//       });
//       String code = next(100000, 999999).toString();
//       String message = T("Your Verification Code is: \n") + code + "\nGenial365 - ERP Solution \n www.genial365.com ";
//       validationCode = code;
//       //  gLogger();
//       //
//       gLogger(message);
//       sendSmsCode("92" + maskFormatter.getUnmaskedText(), message, code);
//       gLogger(response.data.toString());
//     } else if (response.statusCode == 404) {
//       EasyLoading.showError(T("forg_Phone_Number_does_not_exist"));
//     } else {
//       EasyLoading.showError(T("dash_Something_went_wrong"));
//     }
//   }

//   Future<void> sendSmsCode(String toNumber, String messageText, String code) async {
//     String myUsername = "923205666378"; //Your Username At Sendpk.com
//     String myPassword = "D@n1shpuri"; //Your Password At Sendpk.com
//     String masking = "Genial365"; //Your Company Brand Name

//     String url = globals.apiLink + "api/SendSms?phoneno=$toNumber&subject=Message from Technupur&text=" + Uri.encodeFull(messageText);

//     http.get(Uri.parse(url)).then((value) {
//       gLogger(toNumber + value.body);
//     });
//   }

//   var maskFormatter = new MaskTextInputFormatter(mask: '*##-#######', filter: {"#": RegExp(r'[0-9]'), "*": RegExp(r'[1-9]')});
//   TextEditingController _controllerPhoneNo = new TextEditingController();
//   TextEditingController _controllerPhoneNoCountryCode = new TextEditingController(text: "+92");
//   final _formKey = GlobalKey<FormState>();
//   Widget _sendCode() {
//     final height = MediaQuery.of(context).size.height;
//     final width = Responsive.isDesktop(context) ? MediaQuery.of(context).size.width * .35 : MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         height: height,
//         child: Stack(
//           children: <Widget>[
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(horizontal: 25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       //SizedBox(width: width,),
//                       SizedBox(height: height * .01),

//                       _title2(),
//                       SizedBox(
//                         height: 55,
//                       ),
//                       Container(
//                         width: width,
//                         child: Text(
//                           T("forg_Please_enter_your_registered_phone"),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Container(
//                         width: width,
//                         child: Form(
//                           key: _formKey,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 70,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     MyTextFormField(
//                                       controller: _controllerPhoneNoCountryCode,
//                                       isEnabled: false,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: MyTextFormFieldFormated(
//                                   controller: _controllerPhoneNo,
//                                   labelText: T("login_phoneno"),
//                                   inputFormatters: maskFormatter,
//                                   hintText: '331-1234567',
//                                   validator: (value) {
//                                     if (value.length != 11) {
//                                       return T("login_Please_enter_10_digit_phone_no");
//                                     }

//                                     return null;
//                                   },
//                                   onSaved: (value) {},
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 35,
//                       ),
//                       Container(
//                         width: width,
//                         child: RaisedGradientButton(
//                           gradient: LinearGradient(
//                             colors: <Color>[Color(globals.colorCodeYellow), Color(globals.colorCodeGreen)],
//                           ),
//                           child: TextHeading4(
//                             T("forg_Send_Code"),
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               _sendCodeAPI();
//                             }
//                           },
//                         ),
//                       ),

//                       //   _dataFiledsWidget(),
//                       SizedBox(
//                         height: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(top: 40, left: 0, child: _backButton()),
//           ],
//         ),
//       ),
//     );
//   }

//   String validationCode = "";
//   int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
//   Widget _verifyCode() {
//     final height = MediaQuery.of(context).size.height;
//     final width = Responsive.isDesktop(context) ? MediaQuery.of(context).size.width * .35 : MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         height: height,
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               top: -MediaQuery.of(context).size.height * .15,
//               right: -MediaQuery.of(context).size.width * .6,
//               child: BezierContainer(),
//             ),
//             Container(
//                 padding: EdgeInsets.symmetric(horizontal: 25),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                                 width: width,
//                                 child: TextHeading2(
//                                   T("forg_Verification_Code"),
//                                   color: mainColorPrimary,
//                                   textAlign: TextAlign.center,
//                                 )),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             // _title(),
//                             SizedBox(
//                               height: 35,
//                             ),
//                             Container(
//                               width: width,
//                               child: ParagraphNormal(
//                                 "A verification code sent via SMS on this number +" + "92" + maskFormatter.getUnmaskedText(),
//                                 textAlign: TextAlign.center,
//                                 color: Color(0xFF5D6A78),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 35,
//                             ),
//                             Container(
//                               width: width,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                                 child: PinCodeTextField(
//                                   appContext: context,
//                                   errorTextSpace: 0,
//                                   length: 6,
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   animationType: AnimationType.fade,
//                                   pinTheme: PinTheme(
//                                     shape: PinCodeFieldShape.box,
//                                     borderRadius: BorderRadius.circular(5),
//                                     fieldHeight: 50,
//                                     fieldWidth: 40,
//                                     activeFillColor: Colors.white,
//                                   ),
//                                   animationDuration: Duration(milliseconds: 300),
//                                   backgroundColor: Colors.blue.shade50.withOpacity(0.1),
//                                   enableActiveFill: false,
//                                   // errorAnimationController: errorController,
//                                   // controller: textEditingController,
//                                   onCompleted: (v) {
//                                     if (v == validationCode) {
//                                       ProgressDialogCustom(context).hide();
//                                       EasyLoading.showSuccess(T("forg_Code_Verified_update_your_password"));
//                                       setState(() {
//                                         _flag = 2;
//                                       });
//                                       // addUser();
//                                     } else {
//                                       showAlertGlobal(context, T("forg_Your_provided_code_in_invalide"));
//                                     }
//                                   },
//                                   onChanged: (value) {
//                                     gLogger(value);
//                                     setState(() {
//                                       // currentText = value;
//                                     });
//                                   },
//                                   beforeTextPaste: (text) {
//                                     if (isDebug) gLogger("Allowing to paste $text");
//                                     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                                     //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                                     return true;
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               width: width,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     T("forg_Didnt_get_code"),
//                                     style: GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 13, fontWeight: FontWeight.w400),
//                                   ),
//                                   CountdownTimer(
//                                     endTime: endTime,
//                                     widgetBuilder: (_, CurrentRemainingTime? time) {
//                                       // gLogger(time.sec.toString());
//                                       if (time == null) {
//                                         return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   //  _sendVerifyLink();
//                                                   String code = next(100000, 999999).toString();
//                                                   String message = "Your Verification Code is: \n " + code + "\nGenial365 - ERP Solution \n www.genial365.com ";
//                                                   //  gLogger();
//                                                   //
//                                                   validationCode = code;
//                                                   gLogger(message);
//                                                   sendSmsCode("92" + maskFormatter.getUnmaskedText(), message, code);
//                                                   setState(() {
//                                                     endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
//                                                   });
//                                                 },
//                                                 child: Text(
//                                                   T("forg_Resend_Code"),
//                                                   textAlign: TextAlign.end,
//                                                   style: GoogleFonts.poppins(
//                                                       color: Colors.blue, fontSize: 13, decoration: TextDecoration.underline, fontWeight: FontWeight.w500),
//                                                 ),
//                                               ),
//                                             ));
//                                       }
//                                       return Text(
//                                         'Resend code in 00:' + ((time.sec! > 9) ? time.sec.toString() : "0" + time.sec.toString()),
//                                         style: GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 13, fontWeight: FontWeight.w500),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             SizedBox(
//                               height: 35,
//                             ),

//                             // PinFieldAutoFill(
//                             //     decoration:
//                             //         BoxTightDecoration(), // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
//                             //     currentCode: "0000", // prefill with a code
//                             //     //  onCodeSubmitted: //code submitted callback
//                             //     // onCodeChanged: //code changed callback
//                             //     codeLength: 4 //code length, default 6
//                             //     ),
//                             // InkWell(
//                             //     onTap: () {
//                             //       // if (_formKey.currentState.validate()) {
//                             //       //   gLogger(maskFormatter.getUnmaskedText());
//                             //       //   validateEmailAndUserName(
//                             //       //       "92" + maskFormatter.getUnmaskedText());
//                             //     }
//                             //     // validateEmailAndUserName();
//                             //     // if (_controllerUserName.text.trim().isEmpty ||
//                             //     //     _controllerEmailId.text.trim().isEmpty ||
//                             //     //     _controllerPassword.text.trim().isEmpty ||
//                             //     //     _controllerPassword.text.trim().isEmpty) {
//                             //     //   setState(() {
//                             //     //     _controllerUserName.text.trim().isEmpty
//                             //     //         ? _validateUserName = true
//                             //     //         : _validateUserName = false;
//                             //     //     _controllerEmailId.text.trim().isEmpty
//                             //     //         ? _validateEmailId = true
//                             //     //         : _validateEmailId = false;
//                             //     //     _controllerPassword.text.trim().isEmpty
//                             //     //         ? _validatePassword = true
//                             //     //         : _validatePassword = false;
//                             //     //     _controllerVerifyPasswrod.text.trim().isEmpty
//                             //     //         ? _validateVerifyPasswrod = true
//                             //     //         : _validateVerifyPasswrod = false;
//                             //     //   });
//                             //     // } else {
//                             //     //   if (_controllerPassword.text ==
//                             //     //       _controllerVerifyPasswrod.text) {
//                             //     //     globals.regUserName = _controllerUserName.text;
//                             //     //     globals.regUserEmail = _controllerEmailId.text;
//                             //     //     globals.regPassword = _controllerPassword.text;
//                             //     //     _validateValues();
//                             //     //   } else {
//                             //     //     setState(() {
//                             //     //       errorText = "Password didn't match";
//                             //     //       _validateVerifyPasswrod = true;
//                             //     //     });
//                             //     //   }
//                             //     // }
//                             //     ,
//                             //     child: Container(
//                             //       width: MediaQuery.of(context).size.width,
//                             //       padding: EdgeInsets.symmetric(vertical: 15),
//                             //       alignment: Alignment.center,
//                             //       decoration: BoxDecoration(
//                             //           borderRadius: BorderRadius.all(Radius.circular(5)),
//                             //           boxShadow: <BoxShadow>[
//                             //             BoxShadow(
//                             //                 color: Colors.grey.shade200,
//                             //                 offset: Offset(2, 4),
//                             //                 blurRadius: 5,
//                             //                 spreadRadius: 2)
//                             //           ],
//                             //           gradient: LinearGradient(
//                             //               begin: Alignment.centerLeft,
//                             //               end: Alignment.centerRight,
//                             //               colors: [mainColorPrimary, mainColorPrimary])),
//                             //       child: Text(
//                             //         'Verify',
//                             //         style: AppStyle.style20w600(color: Colors.white),
//                             //       ),
//                             //     )),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Row(children: [Container()]),
//                     // _entryField("Username", _controllerUserName, _validateUserName),
//                     // _entryField("Email id", _controllerEmailId, _validateEmailId),
//                     // _entryField("Password", _controllerPassword, _validatePassword,
//                     //     isPassword: true),
//                     // _entryField("Confirm Password", _controllerVerifyPasswrod,
//                     //     _validateVerifyPasswrod,
//                     //     isPassword: true),
//                   ],
//                 )

//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.center,
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: <Widget>[
//                 //     //SizedBox(width: width,),
//                 //     SizedBox(height: height * .01),

//                 //     _title2(),
//                 //     SizedBox(
//                 //       height: 85,
//                 //     ),
//                 //     _entryField(
//                 //         "Verification Code:",
//                 //         "Enter 6 digit verification code:",
//                 //         _controllerVerifyCode,
//                 //         _validatorVerifyCode),
//                 //     SizedBox(
//                 //       height: 15,
//                 //     ),
//                 //     Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.end,
//                 //       mainAxisAlignment: MainAxisAlignment.end,
//                 //       children: <Widget>[
//                 //         Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: Align(
//                 //               alignment: Alignment.centerRight,
//                 //               child: GestureDetector(
//                 //                 onTap: () {
//                 //                   _sendVerifyLink();
//                 //                 },
//                 //                 child: Text(
//                 //                   "Resend Code",
//                 //                   textAlign: TextAlign.end,
//                 //                   style: TextStyle(
//                 //                       color: Colors.blue,
//                 //                       decoration: TextDecoration.underline,
//                 //                       fontSize: 16),
//                 //                 ),
//                 //               ),
//                 //             ))
//                 //       ],
//                 //     ),
//                 //     SizedBox(
//                 //       height: 15,
//                 //     ),
//                 //     RaisedGradientButton(
//                 //       gradient: LinearGradient(
//                 //         colors: <Color>[
//                 //           Color(globals.colorCodeYellow),
//                 //           Color(globals.colorCodeGreen)
//                 //         ],
//                 //       ),
//                 //       child: Text(
//                 //         'Verify Code',
//                 //         style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.w900),
//                 //       ),
//                 //       onPressed: () {
//                 //         if (_controllerVerifyCode.text.trim().isEmpty) {
//                 //           setState(() {
//                 //             _controllerVerifyCode.text.trim().isEmpty
//                 //                 ? _validatorVerifyCode = true
//                 //                 : _validatorVerifyCode = false;
//                 //           });
//                 //         } else {
//                 //           if (_controllerVerifyCode.text.length != 6) {
//                 //             setState(() {
//                 //               _controllerVerifyCode.text.length != 6
//                 //                   ? _validatorVerifyCode = true
//                 //                   : _validatorVerifyCode = false;
//                 //             });
//                 //             errorText = "length of code must be 6 digit";
//                 //           } else {
//                 //             _verifyCodeAPI();
//                 //           }
//                 //         }
//                 //       },
//                 //     ),

//                 //     //   _dataFiledsWidget(),
//                 //     SizedBox(
//                 //       height: 15,
//                 //     ),
//                 //     Padding(
//                 //       padding: const EdgeInsets.all(28.0),
//                 //       child: Text(
//                 //         "Verification code has been sent to your email. \n\nYou’ll receive this email within 2 minutes. Be sure to check your spam folder, too.",
//                 //         textAlign: TextAlign.center,
//                 //         style: TextStyle(color: Colors.grey),
//                 //       ),
//                 //     )
//                 //   ],
//                 // ),

//                 ),
//             Positioned(top: 40, left: 0, child: _backButton()),
//           ],
//         ),
//       ),
//     );
//   }

//   bool passwordVisible = true;
//   final _formKeyPassword = GlobalKey<FormState>();
//   Widget _updatePassword() {
//     final height = MediaQuery.of(context).size.height;
//     final width = Responsive.isDesktop(context) ? MediaQuery.of(context).size.width * .35 : MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         height: height,
//         child: Stack(
//           children: <Widget>[
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Form(
//                           key: _formKeyPassword,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               TextHeading2(T("forg_Update_Password"), color: mainColorPrimary),

//                               SizedBox(
//                                 height: 5,
//                               ),
//                               // _title(),
//                               SizedBox(
//                                 height: 35,
//                               ),

//                               Container(
//                                 width: width,
//                                 child: MyTextFormField(
//                                   controller: _controllerPassword,
//                                   labelText: T("login_Password"),
//                                   hintText: T("login_Password"),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       // Based on passwordVisible state choose the icon
//                                       passwordVisible ? Icons.visibility : Icons.visibility_off,
//                                       color: Colors.green,
//                                     ),
//                                     onPressed: () {
//                                       // Update the state i.e. toogle the state of passwordVisible variable
//                                       setState(() {
//                                         passwordVisible = !passwordVisible;
//                                       });
//                                     },
//                                   ),
//                                   isPassword: passwordVisible,
//                                   validator: (value) {
//                                     if (value.length < 7) {
//                                       return T("sing_Password_should_be_minimum_7_characters");
//                                     }

//                                     return null;
//                                   },
//                                   onSaved: (value) {},
//                                 ),
//                               ),
//                               Container(
//                                 width: width,
//                                 child: MyTextFormField(
//                                   controller: _controllerConfirmPassword,
//                                   labelText: T("pass_Confirm_Password"),
//                                   hintText: T("forg_Enter_Password_again"),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       // Based on passwordVisible state choose the icon
//                                       passwordVisible ? Icons.visibility : Icons.visibility_off,
//                                       color: Colors.green,
//                                     ),
//                                     onPressed: () {
//                                       // Update the state i.e. toogle the state of passwordVisible variable
//                                       setState(() {
//                                         passwordVisible = !passwordVisible;
//                                       });
//                                     },
//                                   ),
//                                   isPassword: passwordVisible,
//                                   validator: (value) {
//                                     if (_controllerPassword.text != _controllerConfirmPassword.text) {
//                                       return T("sing_Password_must_be_same");
//                                     }

//                                     return null;
//                                   },
//                                   onSaved: (value) {},
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 width: width,
//                                 child: RaisedGradientButton(
//                                   gradient: LinearGradient(
//                                     colors: <Color>[Color(globals.colorCodeYellow), Color(globals.colorCodeGreen)],
//                                   ),
//                                   child: TextHeading4(
//                                     T("forg_Update_Password"),
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: () {
//                                     if (_formKeyPassword.currentState!.validate()) {
//                                       _updatePasswordApi();
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(top: 40, left: 0, child: _backButton()),
//           ],
//         ),
//       ),
//     );
//   }

//   int _flag = 0;

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     if (_flag == 0) {
//       return _sendCode();
//     } else if (_flag == 1) {
//       return _verifyCode();
//     } else if (_flag == 2) {
//       return _updatePassword();
//     }
//     return _updatePassword();
//   }
// }

// class StockUnitDataClass {
//   final String? id;
//   final List<String>? name;

//   StockUnitDataClass({this.id, this.name});
//   factory StockUnitDataClass.fromJson(Map<String, dynamic> parsedJson) {
//     return new StockUnitDataClass(
//       id: parsedJson['stock_units_id'],
//       name: parsedJson['stock_unit_name'],
//     );
//   }
// }
