import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/bill_payment_controller.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/payment_widget.dart/payment_widget.dart';
import 'package:global365_widgets/src/buttons/custom_radio_button_with_text_and_textSpan.dart';
import 'package:global365_widgets/src/constants/app_assets.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';

class BillPayment extends StatefulWidget {
  const BillPayment({super.key});

  @override
  State<BillPayment> createState() => _BillPaymentState();
}

class _BillPaymentState extends State<BillPayment> {
  final controller = Get.put(BillPaymentController());
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
              width: GResponsive.isMobile(context) ? width - 40 : 960,
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
              child: Row(
                children: [
                  paymentCardsContainer(context),
                  Expanded(child: receiptWidget(context)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: SvgPicture.asset(AppAssets.poweredByIcon, fit: BoxFit.fill, package: packageName),
            ),
          ),
        ],
      ),
    );
  }

  Widget receiptWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90),
      child: Container(
        height: 660,
        padding: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: cancelBorder),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [BoxShadow(color: Color(0x14000000), blurRadius: 20, offset: Offset(0, 0), spreadRadius: 2)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 110,
                height: 22,
                child: SvgPicture.asset('assets/svg/countylogo.svg', fit: BoxFit.fill, package: packageName),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Plan", style: GAppStyle.style12w600(color: bodyText)),
                    const GTextHeading4("Essential", color: bodyTextDark),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total", style: GAppStyle.style12w600(color: bodyText)),
                    const GTextHeading4("\$735", color: bodyTextDark),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("FROM:", style: GAppStyle.style12w600(color: bodyText)),
                    Text("TO:", style: GAppStyle.style12w600(color: bodyText)),
                  ],
                ),
                GSizeW(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("01-11-2024", style: GAppStyle.style12w600(color: bodyTextDark)),
                    Text("31-10-2025", style: GAppStyle.style12w600(color: bodyTextDark)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 36),
            const Align(
              alignment: Alignment.centerLeft,
              child: GTextHeading4("Add-ons", color: titleColor),
            ),
            GSizeH(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1099 E-FILING',
                  textAlign: TextAlign.center,
                  style: GAppStyle.style12w600(color: bodyTextDark),
                ),
                GSizeW(10),
                Expanded(
                  child: DottedBorder(
                    dashPattern: const [6, 3], // Customize dash and gap length
                    color: bodyText,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    customPath: (size) {
                      return Path()
                        ..moveTo(0, 0)
                        ..lineTo(size.width, 0); // Draws a single line
                    },
                    child: const SizedBox(), // Size can be adjusted
                  ),
                ),
                GSizeW(10),
                Text(
                  '\$15.00',
                  textAlign: TextAlign.center,
                  style: GAppStyle.style12w600(color: bodyTextDark),
                ),
              ],
            ),
            GSizeH(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ADDITIONAL USERS(5)',
                  textAlign: TextAlign.center,
                  style: GAppStyle.style12w600(color: bodyTextDark),
                ),
                GSizeW(10),
                Expanded(
                  child: DottedBorder(
                    dashPattern: const [6, 3], // Customize dash and gap length
                    color: bodyText,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    customPath: (size) {
                      return Path()
                        ..moveTo(0, 0)
                        ..lineTo(size.width, 0); // Draws a single line
                    },
                    child: const SizedBox(), // Size can be adjusted
                  ),
                ),
                GSizeW(10),
                Text(
                  '\$18.00',
                  textAlign: TextAlign.center,
                  style: GAppStyle.style12w600(color: bodyTextDark),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Total Payment", style: GAppStyle.style12w600(color: bodyText)),
                GSizeW(10),
                Text("\$768.00", style: GAppStyle.style20w600(color: titleColor)),
              ],
            ),
            SizedBox(height: 14),
            _submitButton(context),
          ],
        ),
      ),
    );
  }

  Widget cardWidget(
    BuildContext context,
    int groupValue,
    int radioValue,
    void Function()? onTap,
    String cardType,
    String cardNumber,
    String cardIcon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GCustomRadioButtonWithTextAndTextSpan(
          groupValue: groupValue,
          radioValue: radioValue,
          onTap: onTap,
          textSpan: TextSpan(
            text: "",
            style: GAppStyle.style14w500(color: Colors.white),
          ),
        ),
        // GSizeW(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(cardIcon, package: packageName),
            GSizeH(4),
            GTextHeading5(cardType, color: Colors.white),
            GSizeH(6),
            Text("**** **** **** $cardNumber", style: GAppStyle.style12w600(color: placeHolderColor)),
          ],
        ),
      ],
    );
  }

  Widget paymentCardsContainer(BuildContext context) {
    return Obx(() {
      return Container(
        width: 320,
        height: 740,
        padding: EdgeInsets.only(top: 40, bottom: 60, left: 32, right: 32),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GTextHeading4("Select Payment Method", color: Colors.white),
            GSizeH(24),
            cardWidget(
              context,
              controller.radioGroupValueForCards.value,
              1,
              () {
                controller.radioGroupValueForCards.value = 1;
              },
              "Visa Card",
              "8547",
              AppAssets.visaWhiteIcon,
            ),
            GSizeH(24),
            cardWidget(
              context,
              controller.radioGroupValueForCards.value,
              2,
              () {
                controller.radioGroupValueForCards.value = 2;
              },
              "Master Card",
              "9925",
              AppAssets.masterCardIcon,
            ),
            const Spacer(),
            GCustomButton(
              onTap: () {
                alertForAddPaymentMethod(
                  context,
                  controller.name,
                  controller.cardNumber,
                  controller.cvv,
                  controller.selectedDateFrom,
                  controller.tecDateFrom,
                  '',
                );
              },
              btnText: "Payment Method",
              bColor: Colors.white.withOpacity(0.25),
              backgroundColor: primaryColor,
              textColor: Colors.white,
              iconColor: Colors.white,
              extraPadding: true,
              isIconLeft: true,
              icon: BootstrapIcons.plus_circle_fill,
            ),
          ],
        ),
      );
    });
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
          height: 37,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
            ],
            color: mainColorPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.creditCardIcon, package: packageName),
              GSizeW(6),
              Text("Pay Now", style: GAppStyle.style14w500(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
