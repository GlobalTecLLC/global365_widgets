import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/payroll_user_invitation/payroll_user_invitation_controller.dart';
import 'package:global365_widgets/src/authentication/signup/payroll_user_invitation/payroll_user_invitation_widgets.dart';
import 'package:global365_widgets/src/constants/app_assets.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class PayrollUserInvitationPage extends StatefulWidget {
  final String invitationCode;
  const PayrollUserInvitationPage({super.key, required this.invitationCode});

  @override
  State<PayrollUserInvitationPage> createState() => _PayrollUserInvitationPageState();
}

class _PayrollUserInvitationPageState extends State<PayrollUserInvitationPage> {
  final PayrollUserInvitationController userInvitationController = Get.put(PayrollUserInvitationController());

  @override
  void initState() {
    super.initState();
    userInvitationController.getInvitedUserData(context, verficationCode: widget.invitationCode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          body: Stack(
            children: [
              const SigninBackground(),

              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Obx(
                      () => Container(
                        width: 500,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            userInvitationController.isgettingData.isTrue
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(50.0),
                                      child: SpinKitThreeBounce(color: secondaryColorOrange, size: 20.0),
                                    ),
                                  )
                                : userInvitationController.statusCode == "200"
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                                          child: Center(child: const AppLogo(height: 50, isLight: true)),
                                        ),
                                      ),
                                      const GSizeH(10),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30),
                                        child: GTextHeading3(userInvitationController.companyName.value, color: bodyTextDark),
                                      ),
                                      const GSizeH(8),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Invited by ',
                                                style: GAppStyle.style13w400(color: bodyTextDark),
                                              ),
                                              TextSpan(
                                                text: userInvitationController.inviterUserName.value,
                                                style: GAppStyle.style13w600(color: bodyTextDark),
                                              ),
                                              TextSpan(
                                                text: ' (${userInvitationController.inviterUserEmail.value})',
                                                style: GAppStyle.style13w400(color: bodyTextDark),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const GSizeH(16),
                                      const Divider(color: borderColor, height: 1),
                                      const GSizeH(16),
                                      userInvitationController.pageNumber.value == 0
                                          ? signUpAndAcceptWidget(context)
                                          : userInvitationController.pageNumber.value == 1
                                          ? signUpWidget(context)
                                          : oTPWidget(context),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                                        child: Center(
                                          child: SvgPicture.asset(AppAssets.poweredByLogoWhiteIcon, width: 100, height: 100),
                                        ),
                                      ),
                                      const GSizeH(10),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                                        child: Text('Not Found', style: GAppStyle.style13w400(color: bodyTextDark)),
                                      ),
                                      // oTPWidget(context),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Positioned.fill(
                bottom: 66,
                child: Align(alignment: Alignment.bottomCenter, child: SvgPicture.asset(AppAssets.poweredByLogoWhiteIcon)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
