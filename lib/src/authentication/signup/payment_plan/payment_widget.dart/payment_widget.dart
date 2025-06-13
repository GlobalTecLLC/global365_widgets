import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/add_card_widget.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';

alertForAddPaymentMethod(
  BuildContext context,
  TextEditingController name,
  TextEditingController number,
  TextEditingController cvv,
  Rx<DateTime> selectedDateFrom,
  TextEditingController tecDateFrom,
  String partyId,
) {
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 440,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: lightBackground2,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    border: Border(
                      left: const BorderSide(color: borderColor),
                      top: const BorderSide(color: borderColor),
                      right: const BorderSide(color: borderColor),
                      bottom: BorderSide(width: 1, color: borderColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GTextHeading5('Add Payment Method'),
                      InkWell(
                        onTap: () {
                          // context.router.pop();
                          // GNav.popNav(context); //TODO
                        },
                        child: SvgPicture.asset('assets/svg/usa/crossicon.svg', package: packageName),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 440,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: const BorderSide(color: borderColor),
                      top: const BorderSide(color: borderColor),
                      right: const BorderSide(color: borderColor),
                      bottom: BorderSide(width: 1, color: borderColor),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text("Enter Card Details", style: GAppStyle.style12w600(color: titleColor)),
                      ),
                      AddCardWidget(),
                    ],
                  ),
                ),
                Container(
                  width: 440,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: lightBackground2,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    border: Border(
                      left: const BorderSide(color: borderColor),
                      top: BorderSide(width: 1, color: borderColor),
                      right: const BorderSide(color: borderColor),
                      bottom: const BorderSide(color: borderColor),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SaveAndCloseButton(
                      //     onTap: () {
                      //       // context.router.pop();
                      // GNav.popNav(context);
                      //       if (searchController.text.isNotEmpty) {
                      //         functionToCallApi(context);
                      //         searchController.text = "";
                      //       }
                      //     },
                      //     btnText: "Ok")
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
