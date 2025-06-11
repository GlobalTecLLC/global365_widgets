import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/software_info_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class SoftwareInfoScreen extends StatelessWidget {
  const SoftwareInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyData(context));
  }

  Widget bodyData(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final SoftwareInfoController controller = Get.put(SoftwareInfoController());
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(color: lightBackgroundColor),
      child: Stack(
        children: [
          Container(height: height, width: width, color: lightBackgroundColor),
          Center(
            child: Container(
              height: 529,
              width: GResponsive.isMobile(context) ? width - 40 : 1114,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: const Color.fromARGB(15, 5, 0, 0),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(child: Column(children: [createAccountWidget(context, controller)])),
            ),
          ),
        ],
      ),
    );
  }

  Widget createAccountWidget(BuildContext context, SoftwareInfoController controller) {
    return Column(
      children: [
        SizedBox(height: 60),
        SizedBox(width: 282, height: 56, child: SvgPicture.asset('assets/imgs/countylogo.svg', fit: BoxFit.fill)),
        SizedBox(height: 40),
        Container(
          // height: 130,
          width: 1050,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: lightBackgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GTextHeading5(
                "Do you use any of the following accounting software?",
              ).marginSymmetric(vertical: 20, horizontal: 20),
              Wrap(
                spacing: 5.0,
                runSpacing: 10.0,
                children: [
                  _buildRadioOption('QuickBooks', 'assets/imgs/quick_book.png', controller),
                  _buildRadioOption('Xero', 'assets/imgs/xero.png', controller),
                  _buildRadioOption('Sage', 'assets/imgs/sage.png', controller),
                  _buildRadioOption('Zoho', 'assets/imgs/zoho.png', controller),
                  _buildRadioOption('Quicken', 'assets/imgs/quciken.png', controller),
                  _buildRadioOption('NetSuite', 'assets/imgs/oracle.png', controller),
                  _buildRadioOption('Excel', 'assets/imgs/excel.png', controller),
                  _buildRadioOption('None', 'assets/imgs/none.png', controller),
                ],
              ),
              GSizeH(20),
            ],
          ),
        ),
        SizedBox(height: 50),
        Row(
          children: [
            Expanded(child: _goBack(context)),
            const Spacer(),
            Expanded(child: _submitButton(context)),
          ],
        ),
        SizedBox(height: 20),
        // Center(
        //   child: TextHeading5("Privacy Policy", color: secondaryColorOrange),
        // ),
      ],
    ).marginSymmetric(horizontal: 80);
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
          Image.asset(imagePath, height: 28, width: 50, fit: BoxFit.contain),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        gLogger("Get Started Pressed");
        if (SoftwareInfoController.to.selectedSoftwareId == 0) {
          GToast.error("Please select a software", context);
          return;
        } else {
          SoftwareInfoController.to.signUp(context);
        }
        // _showMyDialogLoader("");
        // AutoRouter.of(context).push(const BusinessProfileSetupRoute());

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => DashBoard()));
      },
      child: Container(
        height: 48,
        width: 220,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
          ],
          color: mainColorPrimary,
        ),
        child: GTextHeading4("Let's Get Started", color: whiteColor),
      ),
    );
  }

  Widget _goBack(BuildContext context) {
    return InkWell(
      onTap: () {
        // AutoRouter.of(context).pop();
        GNav.popNav(context);
      },
      child: Container(
        height: 48,
        width: 220,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffc4d2d8)),
          // boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
          color: whiteColor,
        ),
        child: GTextHeading4("Go Back"),
      ),
    );
  }
}
