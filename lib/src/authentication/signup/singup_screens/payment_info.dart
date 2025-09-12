import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/add_card_signup_widget.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';

import '../controllers/signup_controller/payment_info_controller.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  final controller = Get.put(PaymentInfoController());
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
      decoration: const BoxDecoration(color: lightBackgroundColor),
      child: Stack(
        children: [
          Container(height: height, width: width, color: lightBackgroundColor),
          Center(
            child: Container(
              // height: 800,
              width: GResponsive.isMobile(context) ? width - 40 : 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: const Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2)),
                ],
              ),
              child: SingleChildScrollView(child: Column(children: [createAccountWidget(context)])),
            ),
          ),
        ],
      ),
    );
  }

  Widget createAccountWidget(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          SizedBox(height: 80),
          SizedBox(
            width: 282,
            height: 56,
            child: SvgPicture.asset(getModuleLogo(), fit: BoxFit.fill, package: packageName),
          ),
          SizedBox(height: 40),
          GTextHeading2("Enter Payment Information"),
          SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "To complete sign up, a refundable ",
                  style: GAppStyle.style15w500(color: bodyTextColor),
                ),
                TextSpan(
                  text: "\$0.99",
                  style: GAppStyle.style15w500(color: titleColor),
                ),
                TextSpan(
                  text: " verification charges will be applied to your card. Please enter your card details to proceed.",
                  style: GAppStyle.style15w500(color: bodyTextColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),

          const AddCardSignUpWidget(),
          SizedBox(height: 40),
          // MyTextFieldForSingleLine(
          //   showheading: true,
          //   labelText: "Name on Card",
          //   isRequired: true,
          //   controller: controller.name,
          //   hintText: "Enter",
          //   // validator: (value) {
          //   //   if (value.isEmpty) {
          //   //     return 'Please enter an first name';
          //   //   }

          //   //   return null;
          //   // },
          // ),
          // CustomSpacer(
          //   h: 16,
          // ),
          // MyTextFieldForSingleLine(
          //   isRequired: true,
          //   showheading: true,
          //   labelText: "Card Number",
          //   controller: controller.cardNumber,
          //   hintText: "Enter",
          //   cardNumber: true,
          //   suffixIcon: Padding(
          //     padding: const EdgeInsets.all(4.0),
          //     child: SvgPicture.asset(
          //       AppAssets.visaIcon,
          //     ),
          //   ),
          //   // validator: (value) {
          //   //   if (value.isEmpty) {
          //   //     return 'Please enter an last name';
          //   //   }

          //   //   return null;
          //   // },
          // ),
          // CustomSpacer(
          //   h: 16,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: VPHWebDate(
          //         labelText: "Expiry Date",
          //         // isShowHeading: false,
          //         selectedDateTO: controller.selectedDateFrom.value,
          //         dateToController: controller.tecDateFrom,
          //         selectedDateFrom: controller.selectedDateFrom.value,
          //         dateFromController: TextEditingController(text: "MM/YY"),
          //       ),
          //     ),
          //     GSizeW(16),
          //     SizedBox(
          //       width: 160,
          //       child: MyTextFieldForSingleLine(
          //         isRequired: true,
          //         showheading: true,
          //         labelText: "CVV",
          //         controller: controller.cvv,
          //         hintText: "Enter",
          //         cvvNumber: true,

          //         // validator: (value) {
          //         //   if (value.isEmpty) {
          //         //     return 'Please enter an last name';
          //         //   }

          //         //   return null;
          //         // },
          //       ),
          //     ),
          //   ],
          // ),
          // CustomSpacer(
          //   h: 40,
          // ),
          // _submitButton(context),
          // SizedBox(
          //   height: 80,
          // ),
        ],
      ).marginSymmetric(horizontal: 80),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // AutoRouter.of(context).push(const SetUpScreenRoute());
        GNav.pushNav(context, GRouteConfig.setUpScreenRoute);
      },
      child: Opacity(
        opacity: (true) ? 1.0 : 0.5,
        child: Container(
          height: 48,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: mainColorPrimary,
          ),
          child: GTextHeading4("Proceed", color: whiteColor),
        ),
      ),
    );
  }
}
