import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/app_assets.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class RedirectLogin extends StatelessWidget {
  const RedirectLogin({required this.redirectcode, super.key});
  final String redirectcode;
  @override
  Widget build(BuildContext context) {
    gLogger("Redirect Login $redirectcode");
    LoginController.to.redirectLogin(context, redirectcode);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: lightBackgroundColor,
          body: Stack(
            children: [
              Container(height: height, width: width, color: lightBackgroundColor),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      width: GResponsive.isMobile(context) ? width - 40 : 500,
                      padding: const EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: GResponsive.isMobile(context) ? 20 : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: whiteColor,
                        boxShadow: const [BoxShadow(color: Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                            child: Center(child: Image(image: const AssetImage(AppAssets.globalGroupLogoLoginImg), width: 100, height: 100)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(BootstrapIcons.arrow_repeat, size: 30, color: primaryColor),
                              const GSizeW(20),
                              Text("Fetching Data", style: GAppStyle.style24w600()),
                            ],
                          ),
                          const GSizeH(20),
                        ],
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
