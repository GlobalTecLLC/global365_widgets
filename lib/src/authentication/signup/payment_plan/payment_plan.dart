// ignore_for_file: sized_box_for_whitespace

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/payment_plan_controller.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/payment_plan_merchant.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/functions/functions.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({super.key});

  @override
  State<PaymentPlan> createState() => _PaymentPlanState();
}

class _PaymentPlanState extends State<PaymentPlan> {
  final PaymentPlanController controller = Get.put(PaymentPlanController());
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSubScriptionPlans(context);
    });
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
      color: primaryColor,
      child: Column(
        children: [
          Container(
            height: 48,
            width: width,
            color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GSizeW(90),
                ((context.width) >= 850)
                    ? Container(
                        height: 30,
                        // width: 152,
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: SvgPicture.asset(
                          "assets/svg/logo_merchant_light.svg",
                          package: packageName,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                        ),
                      )
                    : Container(
                        height: 30,
                        // width: 152,
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: SvgPicture.asset(
                          "assets/svg/g365.svg",
                          package: packageName,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                const Spacer(),
                SizedBox(
                  height: 32,
                  width: 75,
                  child: GCustomButton(
                    onTap: () {
                      // AutoRouter.of(context).push(const LoginPageUSARoute());
                      GNav.pushNav(context, GRouteConfig.loginUsaPageRoute);
                    },
                    btnText: "Login",
                    // bColor: primaryColor,
                    extraPadding: false,

                    backgroundColor: primaryColor,
                    textColor: primaryWhite,
                  ),
                ),
                GSizeW(90),
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    g365Module == G365Module.merchant
                        ? PaymentPlanMerchant()
                        : Column(
                            children: [
                              GSizeH(20),
                              const GTextHeading3("Choose the package that suits your needs", color: primaryColor),
                              GSizeH(10),
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GLabelSemiBold("Monthly"),
                                    GSizeW(5),
                                    CustomSwitch(
                                      value: controller.isYearlyplanActive.value,
                                      onChanged: (value) {
                                        controller.isYearlyplanActive.value = value;
                                        controller.updatedCostMonthLyYearly();
                                      },
                                    ),
                                    GSizeW(5),
                                    GLabelSemiBold("Yearly"),
                                    GSizeW(5),
                                  ],
                                ),
                              ),
                              GSizeH(10),

                              SizedBox(
                                height: 977,
                                width: 1500,
                                child: controller.isPlansListLoading.isTrue
                                    ? globalSpinkit()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 20),
                                              //Essentials
                                              Obx(() {
                                                return Opacity(
                                                  opacity: 0.5,
                                                  child: Container(
                                                    height: 977,
                                                    width: 352,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: controller.selectedPlan.value == "essential"
                                                            ? secondaryColorOrange
                                                            : Colors.grey,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: controller.isPlansListLoading.isTrue
                                                        ? globalSpinkit()
                                                        : Column(
                                                            children: [
                                                              Container(
                                                                height: 40,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackgroundColor,
                                                                  borderRadius: BorderRadius.circular(6),
                                                                ),
                                                                child: const Center(
                                                                  child: GLabelSemiBold("Essentials"),
                                                                ),
                                                              ).marginOnly(top: 20),
                                                              GTextHeading1(
                                                                GAmountFunctions.formateAmount(
                                                                  "100",
                                                                  addCurrency: true,
                                                                ),
                                                                color: primaryColor,
                                                              ),

                                                              const GLabelSemiBold(
                                                                "Estimated Monthly Equivalent",
                                                                color: Colors.grey,
                                                              ).marginOnly(top: 10),
                                                              //Select Plan
                                                              Obx(() {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    // controller.selectedPlan.value = "essential";
                                                                  },
                                                                  child: Container(
                                                                    height: 40,
                                                                    width: 312,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          controller.selectedPlan.value == "essential"
                                                                          ? secondaryColorOrange
                                                                          : Colors.black,
                                                                      borderRadius: BorderRadius.circular(6),
                                                                    ),
                                                                    child: Center(
                                                                      child: GParagraph13(
                                                                        "Select Plan",
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ).marginOnly(top: 20, bottom: 10),
                                                                );
                                                              }),

                                                              buildExpansionPanelList(controller, controller.essential),

                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Basic Reports",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ).marginOnly(top: 10),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    top: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Chat & Email Support",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    top: BorderSide(color: Color(0xffc4d2d8)),
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Elite Onboarding",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 34,
                                                                width: 312,
                                                                child: Text(
                                                                  "*One time fee to assist in setting up account and provide training to help get customer acquainted with Global software",
                                                                  style: GAppStyle.style12w600(),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Additional User Access",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 34,
                                                                width: 312,
                                                                child: Text(
                                                                  "*This account automatically comes with 1 standard user and 1 Accountant/CPA user.",
                                                                  style: GAppStyle.style12w600(),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Recommended Add-Ons",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "Add Additional Entities",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value:
                                                                                controller.addAdditionalEntities.value,
                                                                            onChanged: (value) {
                                                                              controller.addAdditionalEntities.value =
                                                                                  value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "Online Bill Pay",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller.onlineBillPay.value,
                                                                            onChanged: (value) {
                                                                              controller.onlineBillPay.value = value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              //Contractor payments
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "Contractor Payments",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller.contractorPayments.value,
                                                                            onChanged: (value) {
                                                                              controller.contractorPayments.value =
                                                                                  value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              //1099 E-fillings
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "1099 E-Fillings",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller.eFilings.value,
                                                                            onChanged: (value) {
                                                                              controller.eFilings.value = value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 150,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackgroundColor,
                                                                  borderRadius: BorderRadius.circular(6),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    GLabelSemiBold(
                                                                      "Updated Cost",
                                                                      color: const Color(0xff777777),
                                                                    ).marginOnly(top: 5),
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        GTextHeading3("\$").marginOnly(bottom: 20),
                                                                        Text(
                                                                          "185",
                                                                          style: TextStyle(
                                                                            fontSize: 44,
                                                                            fontFamily: 'Montserrat',
                                                                            fontWeight: FontWeight.w600,
                                                                            color: lightBackgroundColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color: Color(0xffbbbbbb),
                                                                    ).marginSymmetric(horizontal: 15),
                                                                    SizedBox(
                                                                      width: 180,
                                                                      child: Container(
                                                                        constraints: BoxConstraints(maxWidth: 180),
                                                                        child: RichText(
                                                                          text: TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: "15% ",
                                                                                style: GAppStyle.style12w600(
                                                                                  color: secondaryColorOrange,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text:
                                                                                    "Promotional Discount applied. A first year monthly saving of ",
                                                                                style: GAppStyle.style12w600(
                                                                                  color: primaryColor,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: "\$250",
                                                                                style: GAppStyle.style12w600(
                                                                                  color: secondaryColorOrange,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ).marginOnly(top: 20),
                                                              Obx(() {
                                                                return Container(
                                                                  height: 40,
                                                                  width: 312,
                                                                  decoration: BoxDecoration(
                                                                    color: controller.selectedPlan.value == "essential"
                                                                        ? secondaryColorOrange
                                                                        : Colors.black,
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  child: Center(
                                                                    child: GParagraph13(
                                                                      "Select Plan",
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ).marginOnly(top: 20);
                                                              }),
                                                            ],
                                                          ),
                                                  ),
                                                );
                                              }),
                                              SizedBox(width: 20),
                                              //Professionals
                                              Obx(() {
                                                return Container(
                                                  height: 977,
                                                  width: 352,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey, width: 1),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: controller.isPlansListLoading.isTrue
                                                      ? globalSpinkit()
                                                      : Column(
                                                          children: [
                                                            GSizeH(20),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(vertical: 10),
                                                              margin: EdgeInsets.symmetric(horizontal: 10),
                                                              decoration: BoxDecoration(
                                                                color: lightBackgroundColor,
                                                                borderRadius: BorderRadius.circular(6),
                                                              ),
                                                              child: Center(
                                                                child: GLabelSemiBold(
                                                                  controller.subscriptionPlansFirstList.value["name"] ??
                                                                      "",
                                                                ),
                                                              ),
                                                            ),
                                                            GTextHeading1(
                                                              controller.isYearlyplanActive.isFalse
                                                                  ? GAmountFunctions.formateAmount(
                                                                      controller
                                                                              .subscriptionPlansFirstList
                                                                              .value["monthlyDisplayPrice"] ??
                                                                          "",
                                                                      addCurrency: true,
                                                                    )
                                                                  : GAmountFunctions.formateAmount(
                                                                      controller
                                                                              .subscriptionPlansFirstList
                                                                              .value["yearlyDisplayPrice"] ??
                                                                          "",
                                                                      addCurrency: true,
                                                                    ),
                                                              color: primaryColor,
                                                            ),
                                                            GSizeH(10),
                                                            GLabelSemiBold(
                                                              "Estimated Monthly Equivalent",
                                                              color: Colors.grey,
                                                            ),
                                                            GSizeH(20),
                                                            //Select Plan
                                                            InkWell(
                                                              onTap: () {
                                                                // controller.selectedPlan.value = "professional";
                                                                // AutoRouter.of(context).push(const SignUpScreenRoute());
                                                                GNav.pushNav(context, GRouteConfig.signUpScreenRoute);
                                                              },
                                                              child: Container(
                                                                // height: 40,
                                                                // width: 312,
                                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                                margin: EdgeInsets.symmetric(horizontal: 10),

                                                                decoration: BoxDecoration(
                                                                  color: controller.selectedPlan.value == "professional"
                                                                      ? secondaryColorOrange
                                                                      : mainColorPrimary,
                                                                  borderRadius: BorderRadius.circular(6),
                                                                ),
                                                                child: Center(
                                                                  child: GParagraph13(
                                                                    "Start 15-Days Free Trial",
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            GSizeH(10),
                                                            Obx(
                                                              () => controller.isPlansListLoading.isTrue
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                        horizontal: 10.0,
                                                                      ),
                                                                      child: buildExpansionPanelDynamicList(
                                                                        controller
                                                                                .subscriptionPlansFirstList
                                                                                .value["features"] ??
                                                                            [],
                                                                      ),
                                                                    ),
                                                            ),

                                                            // Container(
                                                            //   height: 28,
                                                            //   width: 312,
                                                            //   decoration: BoxDecoration(
                                                            //     color: lightBackground3,
                                                            //     borderRadius: BorderRadius.circular(1),
                                                            //   ),
                                                            //   child: Align(
                                                            //     alignment: Alignment.centerLeft,
                                                            //     child: GLabelSemiBold(
                                                            //       "Basic Reports",
                                                            //     ).marginOnly(left: 5),
                                                            //   ),
                                                            // ).marginOnly(top: 10),
                                                            // Container(
                                                            //   height: 28,
                                                            //   width: 312,
                                                            //   decoration: BoxDecoration(
                                                            //       color: lightBackground3, borderRadius: BorderRadius.circular(1), border: const Border(top: BorderSide(color: Color(0xffc4d2d8)))),
                                                            //   child: Align(
                                                            //     alignment: Alignment.centerLeft,
                                                            //     child: GLabelSemiBold(
                                                            //       "Chat & Email Support",
                                                            //     ).marginOnly(left: 5),
                                                            //   ),
                                                            // ),
                                                            // Container(
                                                            //   height: 28,
                                                            //   width: 312,
                                                            //   decoration: BoxDecoration(
                                                            //     color: lightBackground3,
                                                            //     borderRadius: BorderRadius.circular(1),
                                                            //     border: const Border(
                                                            //       top: BorderSide(
                                                            //         color: Color(0xffc4d2d8),
                                                            //       ),
                                                            //       bottom: BorderSide(
                                                            //         color: Color(0xffc4d2d8),
                                                            //       ),
                                                            //     ),
                                                            //   ),
                                                            //   child: Align(
                                                            //     alignment: Alignment.centerLeft,
                                                            //     child: GLabelSemiBold(
                                                            //       "Elite Onboarding",
                                                            //     ).marginOnly(left: 5),
                                                            //   ),
                                                            // ),
                                                            // SizedBox(
                                                            //   height: 34,
                                                            //   width: 312,
                                                            //   child: Text(
                                                            //     "*One time fee to assist in setting up account and provide training to help get customer acquainted with Global software",
                                                            //     style: GAppStyle.style12w600(),
                                                            //     maxLines: 2,
                                                            //   ),
                                                            // ),
                                                            GSizeH(10),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(
                                                                vertical: 0,
                                                                horizontal: 10,
                                                              ),
                                                              margin: EdgeInsets.symmetric(horizontal: 10),
                                                              decoration: BoxDecoration(
                                                                color: lightBackground3,
                                                                borderRadius: BorderRadius.circular(1),
                                                                border: const Border(
                                                                  bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: GLabelSemiBold("Additional User Access"),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                vertical: 0,
                                                                horizontal: 10,
                                                              ),
                                                              child: Text(
                                                                "*${controller.subscriptionPlansFirstList.value["allowedDefaultUsers"] ?? ""}",
                                                                style: GAppStyle.style12w600(),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            GSizeH(10),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(
                                                                vertical: 0,
                                                                horizontal: 10,
                                                              ),
                                                              margin: EdgeInsets.symmetric(horizontal: 10),
                                                              decoration: BoxDecoration(
                                                                color: lightBackground3,
                                                                borderRadius: BorderRadius.circular(1),
                                                                border: const Border(
                                                                  bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: GLabelSemiBold("Recommended Add-Ons"),
                                                              ),
                                                            ),
                                                            GSizeH(5),
                                                            Obx(
                                                              () => controller.isPlansListLoading.isTrue
                                                                  ? Container()
                                                                  : Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                        vertical: 0,
                                                                        horizontal: 10,
                                                                      ),
                                                                      height: 100,
                                                                      child: ListView.builder(
                                                                        itemCount:
                                                                            (controller
                                                                                        .subscriptionPlansFirstList
                                                                                        .value["addOns"] ??
                                                                                    [])
                                                                                .length,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          final addOn = controller
                                                                              .subscriptionPlansFirstList
                                                                              .value["addOns"][index];
                                                                          return Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    height: 12,
                                                                                    width: 12,
                                                                                    child: SvgPicture.asset(
                                                                                      'assets/svg/prefix_icon.svg',
                                                                                      package: packageName,
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                  GSizeW(10),
                                                                                  GLabelSemiBold(addOn["name"]),
                                                                                  Spacer(),
                                                                                  CustomSwitch(
                                                                                    value: addOn["isAddOnRecomended"],
                                                                                    onChanged: (value) {
                                                                                      // controller.proAddAdditionalEntities.value = value;
                                                                                      GToast.info(
                                                                                        context,
                                                                                        "This action can not be done",
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                            ),
                                                            GSizeH(10),
                                                            Container(
                                                              margin: EdgeInsets.symmetric(horizontal: 10),
                                                              decoration: BoxDecoration(
                                                                color: lightBackgroundColor,
                                                                borderRadius: BorderRadius.circular(6),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  GSizeH(10),
                                                                  GLabelSemiBold(
                                                                    "Updated Cost",
                                                                    color: const Color(0xff777777),
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      GTextHeading1(
                                                                        GAmountFunctions.formateAmount(
                                                                          controller.updatedCost.value,
                                                                          addCurrency: true,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Divider(
                                                                    color: Color(0xffbbbbbb),
                                                                  ).marginSymmetric(horizontal: 15),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(
                                                                      horizontal: 8.0,
                                                                    ),
                                                                    child: GParagraphNormal(
                                                                      controller
                                                                              .subscriptionPlansFirstList
                                                                              .value["description"] ??
                                                                          "",
                                                                    ),
                                                                  ),
                                                                  GSizeH(10),
                                                                ],
                                                              ),
                                                            ),
                                                            GSizeH(10),
                                                            // Container(
                                                            //   height: 150,
                                                            //   width: 312,
                                                            //   decoration: BoxDecoration(
                                                            //     color: lightBackgroundColor,
                                                            //     borderRadius: BorderRadius.circular(6),
                                                            //   ),
                                                            //   child: Column(
                                                            //     children: [
                                                            //       GLabelSemiBold(
                                                            //         "Updated Cost",
                                                            //         color: const Color(0xff777777),
                                                            //       ).marginOnly(top: 5),
                                                            //       Row(
                                                            //         crossAxisAlignment: CrossAxisAlignment.center,
                                                            //         mainAxisAlignment: MainAxisAlignment.center,
                                                            //         children: [
                                                            //           GTextHeading3(
                                                            //             "\$",
                                                            //           ).marginOnly(bottom: 20),
                                                            //           Text(
                                                            //             "535",
                                                            //             style: TextStyle(fontSize: 44, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: lightBackgroundColor),
                                                            //           ),
                                                            //         ],
                                                            //       ),
                                                            //       const Divider(
                                                            //         color: Color(0xffbbbbbb),
                                                            //       ).marginSymmetric(horizontal: 15),
                                                            //       SizedBox(
                                                            //         width: 180,
                                                            //         child: Container(
                                                            //           constraints: BoxConstraints(
                                                            //             maxWidth: 180,
                                                            //           ),
                                                            //           child: RichText(
                                                            //             text: TextSpan(
                                                            //               children: [
                                                            //                 TextSpan(
                                                            //                   text: "15% ",
                                                            //                   style: GAppStyle.style12w600(
                                                            //                     color: secondaryColorOrange,
                                                            //                   ),
                                                            //                 ),
                                                            //                 TextSpan(
                                                            //                   text: "Promotional Discount applied. A first year monthly saving of ",
                                                            //                   style: GAppStyle.style12w600(
                                                            //                     color: lightBackgroundColor,
                                                            //                   ),
                                                            //                 ),
                                                            //                 TextSpan(
                                                            //                   text: "\$250",
                                                            //                   style: GAppStyle.style12w600(
                                                            //                     color: secondaryColorOrange,
                                                            //                   ),
                                                            //                 ),
                                                            //               ],
                                                            //             ),
                                                            //           ),
                                                            //         ),
                                                            //       )
                                                            //     ],
                                                            //   ),
                                                            // ).marginOnly(top: 20),
                                                            // InkWell(
                                                            //   onTap: () {
                                                            //     controller.selectedPlan.value = "professional";
                                                            //   },
                                                            //   child: Container(
                                                            //     height: 40,
                                                            //     width: 312,
                                                            //     decoration: BoxDecoration(
                                                            //       color: controller.selectedPlan.value == "professional" ? secondaryColorOrange : Colors.black,
                                                            //       borderRadius: BorderRadius.circular(6),
                                                            //     ),
                                                            //     child: Center(
                                                            //       child: GParagraph13(
                                                            //         "Select Plan",
                                                            //         color: Colors.white,
                                                            //       ),
                                                            //     ),
                                                            //   ).marginOnly(top: 20),
                                                            // ),
                                                          ],
                                                        ),
                                                );
                                              }),

                                              SizedBox(width: 20),
                                              //Enterprise
                                              Opacity(
                                                opacity: 0.5,
                                                child: Obx(() {
                                                  return Container(
                                                    height: 977,
                                                    width: 352,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: controller.selectedPlan.value == "enterprise"
                                                            ? secondaryColorOrange
                                                            : Colors.grey,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: controller.isPlansListLoading.isTrue
                                                        ? globalSpinkit()
                                                        : Column(
                                                            children: [
                                                              Container(
                                                                height: 40,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackgroundColor,
                                                                  borderRadius: BorderRadius.circular(6),
                                                                ),
                                                                child: Center(child: GLabelSemiBold("Enterprise")),
                                                              ).marginOnly(top: 20),
                                                              GTextHeading1(
                                                                GAmountFunctions.formateAmount(
                                                                  "650",
                                                                  addCurrency: true,
                                                                ),
                                                                color: primaryColor,
                                                              ),

                                                              // Row(
                                                              //   crossAxisAlignment: CrossAxisAlignment.center,
                                                              //   mainAxisAlignment: MainAxisAlignment.center,
                                                              //   children: [
                                                              //     GTextHeading3(
                                                              //       "\$",
                                                              //     ).marginOnly(bottom: 20),
                                                              //     Text(
                                                              //       "650",
                                                              //       style: TextStyle(fontSize: 44, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: lightBackgroundColor),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              GLabelSemiBold(
                                                                "Estimated Monthly Equivalent",
                                                                color: Colors.grey,
                                                              ).marginOnly(top: 10),
                                                              //Select Plan
                                                              InkWell(
                                                                onTap: () {
                                                                  // controller.selectedPlan.value = "enterprise";
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  width: 312,
                                                                  decoration: BoxDecoration(
                                                                    color: controller.selectedPlan.value == "enterprise"
                                                                        ? secondaryColorOrange
                                                                        : Colors.black,
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  child: Center(
                                                                    child: GParagraph13(
                                                                      "Select Plan",
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ).marginOnly(top: 20),
                                                              ),

                                                              buildExpansionPanelList(
                                                                controller,
                                                                controller.enterprise,
                                                              ),

                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Basic Reports",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ).marginOnly(top: 10),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    top: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Chat & Email Support",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    top: BorderSide(color: Color(0xffc4d2d8)),
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Elite Onboarding",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 34,
                                                                width: 312,
                                                                child: Text(
                                                                  "*One time fee to assist in setting up account and provide training to help get customer acquainted with Global software",
                                                                  style: GAppStyle.style12w600(),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Additional User Access",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 34,
                                                                width: 312,
                                                                child: Text(
                                                                  "*This account automatically comes with 1 standard user and 1 Accountant/CPA user.",
                                                                  style: GAppStyle.style12w600(),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackground3,
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: GLabelSemiBold(
                                                                    "Recommended Add-Ons",
                                                                  ).marginOnly(left: 5),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "Add Additional Entities",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller
                                                                                .enterAddAdditionalEntities
                                                                                .value,
                                                                            onChanged: (value) {
                                                                              controller
                                                                                      .enterAddAdditionalEntities
                                                                                      .value =
                                                                                  value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "Online Bill Pay",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller.enterOnlineBillPay.value,
                                                                            onChanged: (value) {
                                                                              controller.enterOnlineBillPay.value =
                                                                                  value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              //Contractor payments
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "Contractor Payments",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller
                                                                                .enterContractorPayments
                                                                                .value,
                                                                            onChanged: (value) {
                                                                              controller.enterContractorPayments.value =
                                                                                  value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              //1099 E-fillings
                                                              Container(
                                                                height: 28,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                  border: const Border(
                                                                    bottom: BorderSide(color: Color(0xffc4d2d8)),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 12,
                                                                        width: 12,
                                                                        child: SvgPicture.asset(
                                                                          'assets/svg/prefix_icon.svg',
                                                                          package: packageName,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      ).marginOnly(left: 10, right: 5),
                                                                      GLabelSemiBold(
                                                                        "1099 E-Fillings",
                                                                      ).marginOnly(left: 5),
                                                                      const Spacer(),
                                                                      Obx(
                                                                        () => Padding(
                                                                          padding: EdgeInsets.only(
                                                                            right: 4,
                                                                            top: 3,
                                                                            bottom: 3,
                                                                          ),
                                                                          child: CustomSwitch(
                                                                            value: controller.enterEFilings.value,
                                                                            onChanged: (value) {
                                                                              controller.enterEFilings.value = value;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 150,
                                                                width: 312,
                                                                decoration: BoxDecoration(
                                                                  color: lightBackgroundColor,
                                                                  borderRadius: BorderRadius.circular(6),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    GLabelSemiBold(
                                                                      "Updated Cost",
                                                                      color: const Color(0xff777777),
                                                                    ).marginOnly(top: 5),
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        GTextHeading3("\$").marginOnly(bottom: 20),
                                                                        Text(
                                                                          "735",
                                                                          style: TextStyle(
                                                                            fontSize: 44,
                                                                            fontFamily: 'Montserrat',
                                                                            fontWeight: FontWeight.w600,
                                                                            color: lightBackgroundColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color: Color(0xffbbbbbb),
                                                                    ).marginSymmetric(horizontal: 15),
                                                                    SizedBox(
                                                                      width: 180,
                                                                      child: Container(
                                                                        constraints: BoxConstraints(maxWidth: 180),
                                                                        child: RichText(
                                                                          text: TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: "15% ",
                                                                                style: GAppStyle.style12w600(
                                                                                  color: secondaryColorOrange,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text:
                                                                                    "Promotional Discount applied. A first year monthly saving of ",
                                                                                style: GAppStyle.style12w600(
                                                                                  color: primaryColor,
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: "\$250",
                                                                                style: GAppStyle.style12w600(
                                                                                  color: secondaryColorOrange,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ).marginOnly(top: 20),
                                                              InkWell(
                                                                onTap: () {
                                                                  // controller.selectedPlan.value = "enterprise";
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  width: 312,
                                                                  decoration: BoxDecoration(
                                                                    color: controller.selectedPlan.value == "enterprise"
                                                                        ? secondaryColorOrange
                                                                        : Colors.black,
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  child: Center(
                                                                    child: GParagraph13(
                                                                      "Select Plan",
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ).marginOnly(top: 20),
                                                              ),
                                                            ],
                                                          ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                    // GSizeH(16),
                    SizedBox(width: width)
                    // SizedBox(
                    //   height: 160,
                    //   width: width,
                    //   child: SvgPicture.asset(
                    //     'assets/svg/payment_plan_header.svg',
                    //     fit: BoxFit.fill,
                    //     package: packageName,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpansionPanelList(PaymentPlanController controller, List<Map<String, dynamic>> dataToShow) {
    return Container(
      height: 180,
      width: 312,
      child: ListView.builder(
        itemCount: dataToShow.length,
        itemBuilder: (context, index) {
          final section = dataToShow[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    section["isExpanded"] = !section["isExpanded"];
                  });
                },
                child: Container(
                  height: 30,
                  width: 312,
                  color: const Color(0xFFEEEEEE),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GLabelSemiBold(section["title"]),
                      Icon(section["isExpanded"] ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              if (section["isExpanded"])
                ...section["items"].map<Widget>((item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Container(
                      height: 27,
                      width: 312,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xffc4d2d8))),
                      ),
                      child: GLabelSemiBold(item),
                    ),
                  );
                }).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget buildExpansionPanelDynamicList(List dataToShow) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: dataToShow.length,
        itemBuilder: (BuildContext context, int index) {
          final section = dataToShow[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    section["isExpanded"] = !(section["isExpanded"] ?? false);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GLabelSemiBold(section["name"] ?? ""),
                      Spacer(),
                      Icon(
                        (section["isExpanded"] ?? false) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              GSizeH(5),
              if (section["featureItems"].isNotEmpty && (section["isExpanded"] ?? false))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: section["featureItems"].length,
                    itemBuilder: (BuildContext context, int index) {
                      final featureItem = section["featureItems"][index];
                      return GLabelSemiBold(featureItem["name"]);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 25.0, // Adjust width
        height: 10.0, // Adjust height
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: value ? primaryColor : Colors.grey),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: value ? 15.0 : 0.0,
              right: value ? 0.0 : 15.0,
              child: Container(
                width: 15.0,
                height: 10.0,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
