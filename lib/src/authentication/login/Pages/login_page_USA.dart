import 'package:flutter/material.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/constants.dart';

import '../Widgets/login_widgets.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key, this.inviteCode});
  String? inviteCode;

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
    if (widget.inviteCode != null && widget.inviteCode!.isNotEmpty) {
      LoginController.to.inviteCode.value = widget.inviteCode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              SigninBackground(),
              Positioned.fill(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AppLogo(height: 50),
                            GSizeH(32),
                            ContainerWithShadow(
                              child: Column(
                                children: [
                                  title(context),
                                  emailPasswordWidget(context),
                                  if (g365Module != G365Module.employeePortal) createAccountLabel(context),
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
                          GBodyText("© 2024, Global365 LLC. All Rights Reserved.", color: bodyText, textAlign: TextAlign.center),
                          GSizeH(20),
                        ],
                      ),
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
