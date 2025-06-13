import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/textfileds/my_login_text_field.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';

// Widget biometricButton(BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 8),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               children: [
//                 // IconButton(
//                 //   icon: Icon(Icons.fingerprint),

//                 //   iconSize: 40,
//                 //   color: mainColorPrimary,
//                 // ),
//                 InkWell(
//                   child: const Text("Biometric Login", style: TextStyle(fontWeight: FontWeight.bold)),
//                   onTap: (() {
//                     () {
//                       if (LoginController.to.isSwitched.value) {
//                         SharedPreferences.getInstance().then((prefs) {
//                           if (prefs.getStringList('loginDetailsBiometric') != null &&
//                               prefs.getStringList('loginDetailsBiometric')!.length > 0) {
//                             List temp = prefs.getStringList('loginDetailsBiometric')!;
//                             LoginController.to.usernmae = temp[0];
//                             LoginController.to.password = temp[1];
//                             LoginController.to.authenticate(context);
//                           } else {
//                             // showDialog(
//                             //     context: context,
//                             //     builder: (context) {
//                             //       return CustomDialog(
//                             //         title: "Genial365",
//                             //         content: "",
//                             //         positiveBtnText: "Done",
//                             //         negativeBtnText: "Cancel",
//                             //         widget: Text(
//                             //             "Please login using your username and Password for the first time to enable the biometric login."),
//                             //         positiveBtnPressed: () {
//                             //           // Do something here
//                             //           Navigator.of(context).pop();
//                             //         },
//                             //         widgetButton: TextButton(
//                             //             onPressed: () {
//                             //               Navigator.pop(context);
//                             //             },
//                             //             child: Text("Ok")),

//                             //         // widget: Text("Hello"),
//                             //       );
//                             //    });
//                           }
//                         });
//                       }

//                       // SharedPreferences.getInstance().then((prefs) {
//                       //   if (prefs.getStringList('loginDetails') != null &&
//                       //       prefs.getStringList('loginDetails')!.length > 0) {
//                       //     List<String>? temp =
//                       //         prefs.getStringList('loginDetails');
//                       //     usernmae = temp![0];
//                       //     password = temp[1];
//                       //     loginCustomerBioMetric();
//                       //   }
//                       // });
//                     };
//                   }),
//                 ),
//               ],
//             ),
//             Switch(
//               onChanged: (value) {
//                 if (value) {
//                   // showDialog(
//                   //     context: context,
//                   //     builder: (context) {
//                   //       return CustomDialog(
//                   //         title: "Genial365",
//                   //         content: "",
//                   //         positiveBtnText: "Done",
//                   //         negativeBtnText: "Cancel",
//                   //         widget: Text(
//                   //             "Please login using your username and Password for the first time to enable the biometric login."),
//                   //         positiveBtnPressed: () {
//                   //           // Do something here
//                   //           Navigator.of(context).pop();
//                   //         },
//                   //         widgetButton: TextButton(
//                   //             onPressed: () {
//                   //               Navigator.pop(context);
//                   //             },
//                   //             child: Text("Ok")),
//                   //       );
//                   //     });
//                   // setState(() {
//                   //   isSwitched = value;
//                   // });
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text(T("login_County")),
//                         content: Text(
//                           T("login_You_would_need_to_enter_your_username"),
//                           style: GoogleFonts.poppins(fontSize: 13),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             // color: mainColorPrimary,
//                             // textColor: Colors.white,
//                             // disabledColor: Colors.grey,
//                             // disabledTextColor: Colors.black,
//                             // padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                             // splashColor: Colors.greenAccent,
//                             style: TextButton.styleFrom(
//                               foregroundColor: mainColorPrimary,
//                               disabledBackgroundColor: Colors.grey,
//                               padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//                             ),
//                             child: Text(T("login_No"), style: GoogleFonts.poppins(color: Colors.black)),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                           TextButton(
//                             // color: mainColorPrimary,
//                             // textColor: Colors.white,
//                             // disabledColor: Colors.grey,
//                             // disabledTextColor: Colors.black,
//                             // padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                             // splashColor: Colors.greenAccent,
//                             style: TextButton.styleFrom(
//                               foregroundColor: mainColorPrimary,
//                               disabledBackgroundColor: Colors.grey,
//                               padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//                             ),
//                             child: Text(T("login_Yes"), style: GoogleFonts.poppins(color: Colors.black)),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               SharedPreferences.getInstance().then((prefs) {
//                                 prefs.setBool('biometricEnable', false);
//                                 prefs.setStringList('loginDetailsBiometric', []);
//                               });
//                               // setState(() {
//                               LoginController.to.isSwitched.value = false;
//                               // });
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               value: LoginController.to.isSwitched.value,
//               activeColor: mainColorPrimary,
//               activeTrackColor: mainColorPrimaryYellow,
//               inactiveThumbColor: Colors.grey,
//               inactiveTrackColor: mainColorPrimaryYellow,
//             ),
//             // Container(
//             //   // width: MediaQuery.of(context).size.width,
//             //   padding: EdgeInsets.symmetric(vertical: 15),
//             //   alignment: Alignment.center,
//             //   decoration: BoxDecoration(
//             //       borderRadius: BorderRadius.all(Radius.circular(5)),
//             //       boxShadow: <BoxShadow>[
//             //         BoxShadow(
//             //             color: Colors.grey.shade200,
//             //             offset: Offset(2, 4),
//             //             blurRadius: 5,
//             //             spreadRadius: 2)
//             //       ],
//             //       gradient: LinearGradient(
//             //           begin: Alignment.centerLeft,
//             //           end: Alignment.centerRight,
//             //           colors: [Color(0xfffadd13), mainColorPrimary])),
//             //   child: Text(
//             //     'Login',
//             //     style: AppStyle.style20w600(color: Colors.white),
//             //   ),
//             // ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

Widget title(BuildContext context) {
  return Column(
    children: [
      GSizeH(10),
      SizedBox(width: 282, height: 56, child: SvgPicture.asset('assets/imgs/countylogo.svg', fit: BoxFit.fill)),
      GSizeH(20),
      Text("Sign In", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
      GSizeH(20),
    ],
  );
}

Widget emailPasswordWidget(BuildContext context) {
  return Obx(
    () => Column(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            // key: LoginController.to.formKey,
            child: Column(
              children: <Widget>[
                if (LoginController.to.checkedValueEmailLogin.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => GLoginEmailField(
                          showheading: true,
                          labelText: "Email",
                          controller: LoginController.to.tecEmail,
                          hintText: "Enter Email",
                          isEnabled: (isLoggingInInvitedUser.isTrue) ? false : true,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter an email address';
                          //   }
                          //   final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          //   if (!emailRegExp.hasMatch(value)) {
                          //     return 'Please enter a valid email address';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      GSizeH(24),
                    ],
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!LoginController.to.checkedValueEmailLogin.value)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone No",
                            style: TextStyle(fontWeight: FontWeight.w700, color: titleColor, fontSize: 14),
                          ),
                          const GSizeH(6),
                          // IntlPhoneField( //TODO
                          //   controller: LoginController.to.controllerusernmae,
                          //   showDropdownIcon: false,
                          //   // countries: ["Pakistan"],
                          //   // textAlign: TextAlign.left,
                          //   // dropdownIconPosition: IconPosition.trailing,
                          //   //  inputFormatters: [maskFormatter],
                          //   flagsButtonPadding: const EdgeInsets.only(left: 5, right: 5),
                          //   decoration: const InputDecoration(
                          //     //  labelText: 'Phone Number',

                          //     // contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          //     hintText: '3311234567',
                          //     border: OutlineInputBorder(borderSide: BorderSide()),
                          //   ),

                          //   // validator: (value) {
                          //   //   if (value!.number.length != 11) {
                          //   //     return T("login_Please_enter_10_digit_phone_no");
                          //   //   }
                          //   //   return null;
                          //   // },
                          //   initialCountryCode: 'PK',
                          //   onChanged: (phone) {
                          //     gLogger(phone.completeNumber);
                          //     // setState(() {
                          //     LoginController.to.phoneNumber.value = phone.completeNumber;
                          //     // });
                          //   },
                          //   onCountryChanged: (country) {
                          //     gLogger('Country changed to: ' + country.name);
                          //   },
                          //   onSaved: (value) {},
                          // ),
                        ],
                      ),
                    GLoginEmailField(
                      showheading: true,
                      labelText: "Password",
                      controller: LoginController.to.controllerpassword,
                      hintText: "Enter Password",
                      isEnabled: !LoginController.to.loogingIn.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          LoginController.to.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                          color: Colors.green,
                        ),
                        alignment: Alignment.centerLeft,
                        iconSize: 16,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          LoginController.to.passwordVisible.value = !(LoginController.to.passwordVisible.value);
                        },
                      ),
                      isPassword: LoginController.to.passwordVisible.value,
                      onFieldSubmitted: (value) {
                        LoginController.to.login(context);
                        // if (LoginController.to.formKey.currentState!.validate()) {
                        //   LoginController.to.login(context);
                        // }
                      },
                      // validator: (value) {
                      //   if (value.length < 2) {
                      //     return T("login_Password_should_be_minimum");
                      //   }
                      //   LoginController.to.formKey.currentState!.save();
                      //   return null;
                      // },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: secondaryColorOrange,
                              value: LoginController.to.checkedValue.value,
                              splashRadius: 0,
                              side: BorderSide(color: borderColor, width: 2),
                              onChanged: (value) {
                                // setState(() {
                                LoginController.to.checkedValue.value = !LoginController.to.checkedValue.value;
                                // });
                              },
                            ),
                          ),
                          GSizeW(9),
                          InkWell(
                            onTap: () {
                              // setState(() {
                              LoginController.to.checkedValue.value = !LoginController.to.checkedValue.value;
                              // });
                            },
                            child: Text(
                              "Remember Me",
                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        // onTap: () async {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                        // },
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.w500, color: secondaryColorOrange, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                GSizeH(30),
                (!LoginController.to.loogingIn.value) ? _submitButton(context) : _submitButtonProcess(context),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _submitButton(BuildContext context) {
  return InkWell(
    onTap: () {
      // _showMyDialogLoader("");
      // if (LoginController.to.formKey.currentState!.validate()) {
      LoginController.to.login(context);
      // }

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => DashBoard()));
    },
    child: Container(
      height: 48,
      width: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
        ],
        color: mainColorPrimary,
      ),
      child: Text(
        "Sign Up",
        style: TextStyle(fontWeight: FontWeight.w700, color: whiteColor, fontSize: 18),
      ),
    ),
  );
}

Widget _submitButtonProcess(BuildContext context) {
  return Container(
    height: 48,
    width: double.maxFinite,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
      ],
      color: mainColorPrimary,
    ),
    child: SpinKitThreeBounce(color: mainColorSecondry, size: 20),
  );
}

Widget createAccountLabel(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 30),
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have a Global365 Account?",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
        ),
        GSizeW(4),
        InkWell(
          onTap: () {
            // logEvent("ClickOnRegister", {});

            isFirstpurchase = true;
            // AutoRouter.of(context).push(const PaymentPlanRoute());
            GNav.pushNav(context, GRouteConfig.paymentPlanRoute);

            // Modular.to.pushNamed("/Pricing");
            // Modular.to.pushNamed("/SubscriptionPlans");
          },
          child: Text(
            "Sign Up Now",
            style: TextStyle(fontWeight: FontWeight.w500, color: secondaryColorOrange, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
