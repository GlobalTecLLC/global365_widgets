import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
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
          const SigninBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 282,
                  height: 56,
                  child: SvgPicture.asset(getModuleLogo(), fit: BoxFit.fill, package: packageName),
                ),
                GSizeH(32),
                ContainerWithShadow(
                  width: GResponsive.isMobile(context) ? width - 40 : 500,
                  child: SingleChildScrollView(child: createAccountWidget(context)),
                ),
              ],
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
          SizedBox(height: 32),

          const AddCardSignUpWidget(),
          SizedBox(height: 32),
          
        ],
      ),
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
