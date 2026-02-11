import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/software_info_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class SoftwareInfoScreen extends StatefulWidget {
  const SoftwareInfoScreen({super.key});

  @override
  State<SoftwareInfoScreen> createState() => _SoftwareInfoScreenState();
}

class _SoftwareInfoScreenState extends State<SoftwareInfoScreen> {
  late final SoftwareInfoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SoftwareInfoController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyData(context));
  }

  Widget bodyData(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          const SigninBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(height: 50),
                SizedBox(height: 32),
                ContainerWithShadow(
                  width: 700,
                  child: SingleChildScrollView(child: Column(children: [createAccountWidget(context, controller)])),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createAccountWidget(BuildContext context, SoftwareInfoController controller) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GTextHeading5("Do you use any of the following accounting software?"),
            GSizeH(16),
            Wrap(
              spacing: 5.0,
              runSpacing: 10.0,
              children: [
                _buildRadioOption('QuickBooks', 'assets/svg/quick_book.png', controller),
                _buildRadioOption('Xero', 'assets/svg/xero.png', controller),
                _buildRadioOption('Sage', 'assets/svg/sage.png', controller),
                _buildRadioOption('Zoho', 'assets/svg/zoho.png', controller),
                _buildRadioOption('Quicken', 'assets/svg/quciken.png', controller),
                _buildRadioOption('NetSuite', 'assets/svg/oracle.png', controller),
                _buildRadioOption('Excel', 'assets/svg/excel.png', controller),
                _buildRadioOption('None', 'assets/svg/none.png', controller),
              ],
            ),
            GSizeH(20),
          ],
        ),
        SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: _goBack(context)),
            const Spacer(),
            Expanded(child: _submitButton(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, String imagePath, SoftwareInfoController controller) {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 10),
          Radio<String>(
            activeColor: secondaryColorOrange,
            value: label,
            groupValue: controller.selectedSoftware.value,
            onChanged: (value) {
              controller.setSelectedSoftware(value!);
            },
          ),
          Image.asset(imagePath, height: 28, width: 50, fit: BoxFit.contain, package: packageName),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      focusNode: controller.letsGetStartedButtonFocusNode,
      onTap: () {
        gLogger("Get Started Pressed");
        if (controller.selectedSoftwareId.value == 0) {
          GToast.error("Please select a software", context);
          return;
        } else {
          controller.signUp(context);
        }
        // _showMyDialogLoader("");
        // AutoRouter.of(context).push(const BusinessProfileSetupRoute());

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => DashBoard()));
      },
      child: AnimatedBuilder(
        animation: controller.letsGetStartedButtonFocusNode,
        builder: (context, child) {
          final hasFocus = controller.letsGetStartedButtonFocusNode.hasFocus;
          return Container(
            height: 48,
            width: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: hasFocus
                  ? <BoxShadow>[
                      BoxShadow(
                        color: secondaryColorOrange.withOpacity(0.2),
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  : <BoxShadow>[
                      BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)
                    ],
              color: mainColorPrimary,
              border: hasFocus ? Border.all(color: secondaryColorOrange, width: 1) : null,
            ),
            child: GTextHeading4("Let's Get Started", color: whiteColor),
          );
        },
      ),
    );
  }

  Widget _goBack(BuildContext context) {
    return InkWell(
      focusNode: controller.goBackButtonFocusNode,
      onTap: () {
        // AutoRouter.of(context).pop();
        GNav.popNav(context);
      },
      child: AnimatedBuilder(
        animation: controller.goBackButtonFocusNode,
        builder: (context, child) {
          final hasFocus = controller.goBackButtonFocusNode.hasFocus;
          return Container(
            height: 48,
            width: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: hasFocus ? secondaryColorOrange : const Color(0xffc4d2d8), width: 1),
              boxShadow: hasFocus
                  ? <BoxShadow>[
                      BoxShadow(
                        color: secondaryColorOrange.withOpacity(0.2),
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
              color: whiteColor,
            ),
            child: GTextHeading4("Go Back"),
          );
        },
      ),
    );
  }
}
