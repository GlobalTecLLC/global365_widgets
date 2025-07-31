import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/payment_plan_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/functions/functions.dart';

class PaymentPlanMerchant extends StatelessWidget {
  PaymentPlanMerchant({super.key});
  final PaymentPlanController controller = Get.put(PaymentPlanController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GSizeH(20),
        const GTextHeading3("Choose the package that suits your needs", color: primaryColor),
        GSizeH(10),

        SizedBox(
          height: 710,
          width: 1500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  //Essentials
                  Container(
                    height: 710,
                    width: 352,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: borderColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: lightBackgroundColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(child: GLabelSemiBold("Traditional")),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text("\$", style: GAppStyle.style24w700()),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("0", style: GAppStyle.style50w600()),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text("/month*", style: GAppStyle.style20w600()),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Text(
                          "*(Minimum monthly platform fee of \$35.00/month CC's and \$15.00/month for ACH)",
                          textAlign: TextAlign.center,
                          style: GAppStyle.style10w600(),
                        ),
                        GSizeH(16),
                        //Select Plan
                        InkWell(
                          onTap: () {
                            // controller.selectedPlan.value = "professional";
                            // AutoRouter.of(context).push(const SignUpScreenRoute());
                            GNav.pushNav(context, GRouteConfig.signUpScreenRoute);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),

                            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(6)),
                            child: Center(child: GParagraph13("Select Plan", color: Colors.white)),
                          ),
                        ),
                        GSizeH(16),
                        Container(
                          decoration: BoxDecoration(
                            color: lightBackgroundColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                'Credit Card',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style16w600(color: bodyTextDark),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '3.99% ',
                                    textAlign: TextAlign.center,
                                    style: GAppStyle.style24w600(color: primaryColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text("per transaction", style: GAppStyle.style14w600(color: primaryColor)),
                                  ),
                                ],
                              ),
                              Text(
                                '+',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style16w600(color: bodyTextDark),
                              ),
                              Text(
                                'ACH',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style16w600(color: bodyTextDark),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '1% ',
                                    textAlign: TextAlign.center,
                                    style: GAppStyle.style24w600(color: primaryColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text("per transaction", style: GAppStyle.style14w600(color: primaryColor)),
                                  ),
                                ],
                              ),
                              Text(
                                '(Capped at \$5.00)',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style12w600(color: bodyTextDark),
                              ),
                              GSizeH(8),
                              const Divider(color: Color(0xffbbbbbb), height: 1),
                              GSizeH(8),

                              SizedBox(
                                child: Container(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Business owner pays all the ",
                                          style: GAppStyle.style12w400(color: primaryColor),
                                        ),
                                        TextSpan(
                                          text: "Credit Card ",
                                          style: GAppStyle.style12w600(color: secondaryColorOrange),
                                        ),
                                        TextSpan(
                                          text: "and ",
                                          style: GAppStyle.style12w400(color: primaryColor),
                                        ),
                                        TextSpan(
                                          text: "ACH ",
                                          style: GAppStyle.style12w600(color: secondaryColorOrange),
                                        ),
                                        TextSpan(
                                          text: "fees.",
                                          style: GAppStyle.style12w400(color: primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GSizeH(16),
                        buildExpansionPanelList([
                          {"title": "Unlimited invoices & payment links"},
                          {"title": "Real-time transaction tracking"},
                          {"title": "Dashboard analytics & reporting "},
                          {"title": "Secure checkout & PCI compliance"},
                          {"title": "Email Support"},
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    height: 710,
                    width: 352,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: secondaryColorOrange, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: lightBackgroundColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(child: GLabelSemiBold("Dual Pricing")),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text("\$", style: GAppStyle.style24w700()),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("99.95", style: GAppStyle.style50w600()),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Text("/month*", style: GAppStyle.style20w600()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Text(
                                "*(Billed as Monthly Platform Fee)",
                                textAlign: TextAlign.center,
                                style: GAppStyle.style10w600(),
                              ),
                              GSizeH(16),
                              //Select Plan
                              InkWell(
                                onTap: () {
                                  // controller.selectedPlan.value = "professional";
                                  // AutoRouter.of(context).push(const SignUpScreenRoute());
                                  GNav.pushNav(context, GRouteConfig.signUpScreenRoute);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),

                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(child: GParagraph13("Select Plan", color: Colors.white)),
                                ),
                              ),
                              GSizeH(16),
                              Container(
                                decoration: BoxDecoration(
                                  color: lightBackgroundColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Credit Card',
                                      textAlign: TextAlign.center,
                                      style: GAppStyle.style16w600(color: bodyTextDark),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '0% ',
                                          textAlign: TextAlign.center,
                                          style: GAppStyle.style24w600(color: primaryColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            "per transaction**",
                                            style: GAppStyle.style14w600(color: primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '+',
                                      textAlign: TextAlign.center,
                                      style: GAppStyle.style16w600(color: bodyTextDark),
                                    ),
                                    Text(
                                      'ACH',
                                      textAlign: TextAlign.center,
                                      style: GAppStyle.style16w600(color: bodyTextDark),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '0% ',
                                          textAlign: TextAlign.center,
                                          style: GAppStyle.style24w600(color: primaryColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            "per transaction",
                                            style: GAppStyle.style14w600(color: primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),

                                    GSizeH(8),
                                    const Divider(color: Color(0xffbbbbbb), height: 1),
                                    GSizeH(8),

                                    SizedBox(
                                      child: Container(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "**Business owner offers customer option to pay via ",
                                                style: GAppStyle.style12w400(color: primaryColor),
                                              ),
                                              TextSpan(
                                                text: "ACH/Cash  ",
                                                style: GAppStyle.style12w600(color: secondaryColorOrange),
                                              ),
                                              TextSpan(
                                                text: "as an incentive for customers by providing a ",
                                                style: GAppStyle.style12w400(color: primaryColor),
                                              ),
                                              TextSpan(
                                                text: "3.99% ",
                                                style: GAppStyle.style12w600(color: secondaryColorOrange),
                                              ),
                                              TextSpan(
                                                text: "discount on their transaction.",
                                                style: GAppStyle.style12w400(color: primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GSizeH(16),
                              buildExpansionPanelList([
                                {"title": "3.99% Discount on Cash/ACH Payments"},
                                {"title": "Unlimited invoices & payment links"},
                                {"title": "Real-time transaction tracking "},
                                {"title": "Dashboard analytics & reporting "},
                                {"title": "Secure checkout & PCI compliance"},
                                {"title": "Email  and Chat support"},
                              ]),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 10,
                          child: Icon(BootstrapIcons.bookmark_star_fill, color: secondaryColorOrange, size: 50),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 710,
                    width: 352,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: borderColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: lightBackgroundColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(child: GLabelSemiBold("Custom")),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text("Let’s Talk", style: GAppStyle.style50w600())],
                            ),
                          ],
                        ),

                        Text(
                          "For Large/Enterprise Merchants",
                          textAlign: TextAlign.center,
                          style: GAppStyle.style10w600(),
                        ),
                        GSizeH(16),
                        //Select Plan
                        InkWell(
                          onTap: () {
                            showModleForContactUs(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),

                            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(6)),
                            child: Center(child: GParagraph13("Contact Us", color: Colors.white)),
                          ),
                        ),
                        GSizeH(16),
                        Container(
                          decoration: BoxDecoration(
                            color: lightBackgroundColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                'Credit Card',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style16w600(color: bodyTextDark),
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       '3.99% ',
                              //       textAlign: TextAlign.center,
                              //       style: GAppStyle.style24w600(color: primaryColor),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(bottom: 4.0),
                              //       child: Text("per transaction", style: GAppStyle.style14w600(color: primaryColor)),
                              //     ),
                              //   ],
                              // ),
                              Text(
                                '+',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style16w600(color: bodyTextDark),
                              ),
                              Text(
                                'ACH',
                                textAlign: TextAlign.center,
                                style: GAppStyle.style16w600(color: bodyTextDark),
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       '1% ',
                              //       textAlign: TextAlign.center,
                              //       style: GAppStyle.style24w600(color: primaryColor),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(bottom: 4.0),
                              //       child: Text("per transaction", style: GAppStyle.style14w600(color: primaryColor)),
                              //     ),
                              //   ],
                              // ),
                              // Text(
                              //   '(Capped at \$5.00)',
                              //   textAlign: TextAlign.center,
                              //   style: GAppStyle.style12w600(color: bodyTextDark),
                              // ),
                              GSizeH(8),
                              const Divider(color: Color(0xffbbbbbb), height: 1),
                              GSizeH(8),

                              SizedBox(
                                child: Container(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "(Already processing? Do you have  ",
                                          style: GAppStyle.style12w400(color: primaryColor),
                                        ),
                                        TextSpan(
                                          text: "\$10,000 ",
                                          style: GAppStyle.style12w600(color: secondaryColorOrange),
                                        ),
                                        TextSpan(
                                          text: "or more per month in ",
                                          style: GAppStyle.style12w400(color: primaryColor),
                                        ),
                                        TextSpan(
                                          text: "CC or ACH ",
                                          style: GAppStyle.style12w600(color: secondaryColorOrange),
                                        ),
                                        TextSpan(
                                          text: "transactions.",
                                          style: GAppStyle.style12w400(color: primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GSizeH(16),
                        buildExpansionPanelList([
                          {"title": "Lower processing fees"},
                          {"title": "Large transaction volumes"},
                          {"title": "3.99% Discount on Cash/ACH Payments"},

                          {"title": "Unlimited invoices & payment links"},
                          {"title": "Real-time transaction tracking"},
                          {"title": "Dashboard analytics & reporting "},
                          {"title": "Secure checkout & PCI compliance"},
                          {"title": "Email, Chat and Live Call support"},
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildExpansionPanelList(List<Map<String, dynamic>> dataToShow) {
    RxBool isExpanded = true.obs;
    return Container(
      // height: 180,
      child: Obx(
        () => Column(
          children: [
            GestureDetector(
              onTap: () {
                isExpanded.value = !isExpanded.value;
              },
              child: Container(
                height: 30,

                color: const Color(0xFFEEEEEE),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GLabelSemiBold("Plan Features"),
                    Icon(isExpanded.isTrue ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            if (isExpanded.isTrue)
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dataToShow.length,
                itemBuilder: (context, index) {
                  final section = dataToShow[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(BootstrapIcons.check_circle, color: primaryColor, size: 16),
                            GSizeW(8),
                            Expanded(child: GLabelSemiBold(section["title"] ?? "")),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  static showModleForContactUs(context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        border: Border(
                          left: const BorderSide(color: placeHolderColor),
                          top: const BorderSide(color: placeHolderColor),
                          right: const BorderSide(color: placeHolderColor),
                          bottom: BorderSide(width: 1, color: placeHolderColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const GTextHeading4('Contact for Pricing'),
                          InkWell(
                            onTap: () {
                              // context.router.pop();
                              GNav.popNav(context);
                            },
                            child: SvgPicture.asset('assets/icons/crossicon.svg'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      // height: MediaQuery.of(context).size.height / 1.5,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: const BorderSide(color: placeHolderColor),
                          top: const BorderSide(color: placeHolderColor),
                          right: const BorderSide(color: placeHolderColor),
                          bottom: BorderSide(width: 1, color: placeHolderColor),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const GTextHeading5("Contact Us", color: primaryColor),
                            GSizeH(8),
                            Row(
                              children: [
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    hintText: "Enter your name",
                                    labelText: "Bussiness Name",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    hintText: "Enter your name",
                                    labelText: "Bussiness Type",
                                    controller: TextEditingController(),
                                  ),
                                ),
                              ],
                            ),
                            GSizeH(10),
                            GTextFieldForSingleLine(
                              containerHeight: 100,
                              maxLine: 5,
                              hintText: "Enter Brief Description of your Bussiness",
                              labelText: "Brief Description",
                              controller: TextEditingController(),
                              isCustomHeight: true,
                            ),
                            GSizeH(10),
                            Row(
                              children: [
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    hintText: "Enter Contact Name",
                                    labelText: "Contact Name",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    hintText: "321 654 9870",
                                    labelText: "Contact Phone Number",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    hintText: "Enter Contact Email Address",
                                    labelText: "Contact Email Address",
                                    controller: TextEditingController(),
                                  ),
                                ),
                              ],
                            ),
                            GSizeH(24),
                            Divider(color: placeHolderColor, height: 1),
                            GSizeH(16),
                            const GTextHeading5("Finance Information", color: primaryColor),
                            GSizeH(8),
                            Row(
                              children: [
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "Average Monthly Credit Card Volume",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "Average Monthly ACH Volume",
                                    controller: TextEditingController(),
                                  ),
                                ),
                              ],
                            ),
                            GSizeH(10),
                            Row(
                              children: [
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "Year-to-date Credit Card Volume",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "Year-to-date ACH Volume",
                                    controller: TextEditingController(),
                                  ),
                                ),
                              ],
                            ),
                            GSizeH(24),
                            Divider(color: placeHolderColor, height: 1),
                            GSizeH(16),
                            const GTextHeading5("Last 3 Months Totals", color: primaryColor),
                            GSizeH(8),
                            Row(
                              children: [
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "June 2025",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "May 2025",
                                    controller: TextEditingController(),
                                  ),
                                ),
                                GSizeW(10),
                                Expanded(
                                  child: GTextFieldForSingleLine(
                                    labelText: "April 2025",
                                    controller: TextEditingController(),
                                  ),
                                ),
                              ],
                            ),
                            GSizeH(24),
                            GLabelSemiBold("Upload Statements (Optional)"),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 100,
                              decoration: BoxDecoration(
                                color: lightBackgroundColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(child: Icon(BootstrapIcons.filetype_pdf, size: 50, color: primaryColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border(
                          left: const BorderSide(color: dashSecondHeaderPrimaryColor),
                          top: BorderSide(width: 1, color: dashSecondHeaderPrimaryColor),
                          right: const BorderSide(color: dashSecondHeaderPrimaryColor),
                          bottom: const BorderSide(color: dashSecondHeaderPrimaryColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GCustomButton(
                            onTap: () {},
                            extraPadding: true,
                            btnText: "Cancel",
                            icon: BootstrapIcons.x_circle,

                            variant: ButtonVariant.outlineWhite25,
                          ),
                          GCustomButton(
                            onTap: () {},
                            extraPadding: true,
                            btnText: "Submit",
                            icon: BootstrapIcons.send_fill,

                            variant: ButtonVariant.filledPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
