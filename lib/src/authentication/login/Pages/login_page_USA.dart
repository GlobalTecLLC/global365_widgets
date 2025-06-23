import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

import '../Widgets/login_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<LoginController>()) {
      Get.find<LoginController>();
    } else {
      Get.put(LoginController());
    }
    LoginController.to.checkIsRememberUser();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              Container(height: height, width: width, color: lightBackgroundColor),
              Positioned.fill(
                // top: 150,
                // left: 685,
                // right: 685,
                // bottom: 150,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: GResponsive.isMobile(context) ? width - 40 : 500,
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                                  margin: EdgeInsets.symmetric(horizontal: GResponsive.isMobile(context) ? 20 : 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: whiteColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(15, 5, 0, 0),
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      title(context),
                                      emailPasswordWidget(context),
                                      createAccountLabel(context),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GBodyText(
                                "Global365 are registered trademarks of GlobalGroup.Co, LLC.",
                                color: bodyText,
                                textAlign: TextAlign.center,
                              ),
                              GBodyText(
                                "Terms and conditions, features, and pricing are all subject to change without notice.",
                                color: bodyText,
                                textAlign: TextAlign.center,
                              ),
                              GSizeH(5),
                              GBodyText(
                                "© 2024, Global365 LLC. All Rights Reserved.",
                                color: bodyText,
                                textAlign: TextAlign.center,
                              ),
                              GSizeH(20),
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

LoginController loginController = Get.find();
