import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class JoinExistingCompany extends StatefulWidget {
  const JoinExistingCompany({super.key});

  @override
  State<JoinExistingCompany> createState() => _JoinExistingCompanyState();
}

class _JoinExistingCompanyState extends State<JoinExistingCompany> {
  @override
  Widget build(BuildContext context) {
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
              // height: 572,
              width: GResponsive.isMobile(context) ? width - 40 : 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2))],
              ),
              child: SingleChildScrollView(child: Column(children: [joinExistingCompanyWidget(context)])),
            ),
          ),
        ],
      ),
    );
  }

  List listCompanies = [
    {"companyName": "Technupur", "companyImg": "https://technupur.com/assets/images/technupur-logo.png"},
    {"companyName": "Global365", "companyImg": "https://global365.com/assets/images/global365-logo.png"},
    {"companyName": "Technupur", "companyImg": "https://technupur.com/assets/images/technupur-logo.png"},
    {"companyName": "Global365", "companyImg": "https://global365.com/assets/images/global365-logo.png"},
    {"companyName": "Technupur", "companyImg": "https://technupur.com/assets/images/technupur-logo.png"},
    {"companyName": "Global365", "companyImg": "https://global365.com/assets/images/global365-logo.png"},
  ];

  Widget joinExistingCompanyWidget(BuildContext context) {
    return Column(
      children: [
        GSizeH(80),
        SizedBox(
          width: 282,
          height: 56,
          child: SvgPicture.asset(getModuleLogo(), fit: BoxFit.fill, package: packageName),
        ),
        SizedBox(height: 40),
        GTextHeading2("Welcome ", color: primaryColor),
        SizedBox(height: 40),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GTextHeading5("SELECT COMPANY TO PROCEED", color: bodyText),
                GBodyText("Select an existing company to join Global365 Merchant or create a new organization if you don't have one.", maxLines: 2, color: bodyText),
                const GSizeH(20),
                SizedBox(
                  height: listCompanies.length < 4 ? listCompanies.length * 58 : 270,
                  child: listCompanies.isEmpty
                      ? Padding(padding: EdgeInsets.symmetric(vertical: 20), child: const GBodyText("No Company Found"))
                      : ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 16, color: borderColor, thickness: 1); // Customize your separator here.
                          },
                          itemCount: listCompanies.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: lightBackgroundColor, borderRadius: BorderRadius.circular(30)),
                                          child: g365NetworkImage(
                                            listCompanies[index]["companyImg"] ?? "",
                                            30,
                                            30,
                                            fit: BoxFit.fill,
                                            placeHolderName: listCompanies[index]["companyName"] ?? "",
                                          ),
                                        ),
                                        const GSizeW(10),
                                        GTextHeading4(listCompanies[index]["companyName"] ?? ""),
                                        const Spacer(),
                                        SizedBox(
                                          height: 30,
                                          child: GCustomButton(
                                            onTap: () {},
                                            btnText: "Join",
                                            icon: BootstrapIcons.arrow_right,
                                            variant: ButtonVariant.outlineBodyTextDark,
                                            isIconLeft: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
                const GSizeH(20),

                SizedBox(
                  height: 50,
                  child: GCustomButton(
                    onTap: () {
                      GNav.goNav(context, GRouteConfig.setUpScreenRoute);
                    },
                    btnText: "Create New Organization",
                    icon: BootstrapIcons.buildings_fill,
                    variant: ButtonVariant.outlineBodyTextDark,
                    isIconLeft: true,
                  ),
                ), // Button to create a new organization
                const GSizeH(20),

                //Create a new organization
              ],
            ),
          ),
        ),
        GSizeH(80),
      ],
    ).marginSymmetric(horizontal: 80);
  }
}
