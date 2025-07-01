import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/my_profile_controller.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/functions/global_functions.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/shimmers/custom_shimmer.dart';
import 'package:global365_widgets/src/utils/shimmers/custom_shimmer_widget.dart';
import 'package:intl/intl.dart';

class ProfileScreenWidgetDetails extends StatelessWidget {
  ProfileScreenWidgetDetails({super.key});

  MyProfileController myProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      dynamic profileData = myProfileController.profileData["profile"] ?? {};
      List emailsList = myProfileController.profileData["emails"] ?? [];
      List phonesList = myProfileController.profileData["phones"] ?? [];
      myProfileController.profileImageOnProfilePage.value = profileImage.value;
      return Container(
        height: 715,
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: lightBackgroundColor,
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 1, color: Color(0xFFC3D2D7)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: myProfileController.isProfileDataLoading.isTrue
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GTextHeading5("Personal Information", color: titleColor),
                  GSizeH(10),
                  Row(
                    children: [
                      CustomShimmerWidget(heaight: 60, width: 60, isCircle: true),
                      GSizeW(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerWidget(heaight: 20, width: 120),
                          GSizeH(10),
                          CustomShimmerWidget(heaight: 20, width: 150),
                        ],
                      ),
                    ],
                  ),
                  Expanded(child: CustomShimmer(rowNumbers: 5, columns: 2)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GTextHeading5("Personal Information", color: primaryColor),
                      InkWell(
                        onTap: () async {
                          gLogger("profile image that ${myProfileController.profileImageOnProfilePage.value}");
                          gLogger("profile Data is ${profileData}");

                          myProfileController.tecFirstNameController.text = profileData["firstName"] ?? "";
                          myProfileController.tecMiddleNameController.text = profileData["middleName"] ?? "";
                          myProfileController.tecLastNameController.text = profileData["lastName"] ?? "";
                          // MyProfileController.to.profileIMagePath = profileData["filePath"] ?? "";
                          myProfileController.tecJobTitleController.text = profileData["jobTitle"] ?? "";
                          myProfileController.selectedDateFromforBirthday =
                              DateTime.tryParse(profileData["birthday"].toString()) ?? DateTime.now();
                          myProfileController.tecDateFromControllerBirthday = TextEditingController(
                            text: DateFormat(
                              'MM/dd/yyyy',
                            ).format(DateTime.tryParse(profileData["birthday"].toString()) ?? DateTime.now()),
                          );
                          // myProfileController.selectedDateFromforAniversary = DateTime.parse(profileData["workAnniversary"] ?? DateTime.now());
                          // myProfileController.tecDateFromControllerAniversary =
                          //     TextEditingController(text: DateFormat('MM/dd/yyyy').format(DateTime.parse(profileData["workAnniversary"] ?? DateTime.now())));
                          myProfileController.partyIdForGender = (profileData["gender"] ?? "") == "Male"
                              ? "1"
                              : (profileData["gender"] ?? 0) == "Female"
                              ? "2"
                              : "3";
                          myProfileController.partyIdForCountryReigon = (profileData["countryId"] ?? 233)
                              .toString(); // null handled as 233 on the instructions of backend team
                          myProfileController.partyIdForTimeZone = (profileData["timeZoneId"] ?? 0).toString();
                          gLogger("Email list $emailsList");
                          List<Map<String, Object>> listtempforEmail = [];

                          for (int i = 0; i < emailsList.length; i++) {
                            Map<String, Object> data = {
                              "emailtextFieldController": TextEditingController(text: emailsList[i]["email"] ?? ""),
                              "isPrimary": emailsList[i]["isPrimary"] ?? false,
                              "isVerified": emailsList[i]["isVerified"] ?? false,
                            };
                            listtempforEmail.add(data);
                          }
                          myProfileController.emailList.clear();
                          myProfileController.emailList.addAll(listtempforEmail);
                          gLogger("Email list ${myProfileController.emailList}");
                          List<Map<String, Object>> listtempforPhone = [];

                          for (int i = 0; i < phonesList.length; i++) {
                            Map<String, Object> data = {
                              "phonetextFieldController": TextEditingController(text: phonesList[i]["phoneNo"] ?? ""),
                              "isPrimary": phonesList[i]["isPrimary"] ?? false,
                              "isVerified": phonesList[i]["isVerified"] ?? false,
                            };
                            listtempforPhone.add(data);
                          }
                          myProfileController.phoneList.clear();
                          myProfileController.phoneList.addAll(listtempforPhone);
                          myProfileController.isUpdatingDropdown.value = true;
                          await Future.delayed(const Duration(milliseconds: 50));
                          myProfileController.isUpdatingDropdown.value = false;
                          myProfileController.isEditProfile.value = !myProfileController.isEditProfile.value;
                        },
                        child: SvgPicture.asset("assets/icons/usa/pencil_square.svg"),
                      ),
                    ],
                  ),
                  const GSizeH(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(
                            () => myProfileController.isUploadingImage.isTrue
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    padding: EdgeInsets.all(16),
                                    decoration: const BoxDecoration(color: lightBackgroundColor),
                                    child: SvgPicture.asset("assets/icons/usa/usersvg.svg", color: primaryColor),
                                  )
                                : Container(
                                    height: 80,
                                    width: 80,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: lightBackgroundColor,
                                      border: Border.all(color: borderColor),
                                      shape: BoxShape.circle,
                                      image: myProfileController.profileImageOnProfilePage.value.isNotEmpty
                                          ? DecorationImage(
                                              image: NetworkImage(myProfileController.profileImageOnProfilePage.value),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: myProfileController.profileImageOnProfilePage.value.isEmpty
                                        ? GCustomIcon(
                                            svgPath: "assets/icons/usa/usersvg.svg",
                                            iconOnly: true,
                                            size: 40,
                                            iconColor: primaryColor,
                                          )
                                        : null,
                                  ),
                          ),
                        ],
                      ),
                      const GSizeW(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GTextHeading4(
                            "${profileData["firstName"] ?? ""}${profileData["firstName"] != null && profileData["firstName"]!.isNotEmpty && (profileData["middleName"] != null || profileData["lastName"] != null) ? " " : ""}${profileData["middleName"] ?? ""}${profileData["middleName"] != null && profileData["middleName"]!.isNotEmpty && profileData["lastName"] != null ? " " : ""}${profileData["lastName"] ?? ""}",
                            color: primaryColor,
                          ),
                          const GSizeH(4),
                          if ((profileData["firstName"] ?? "").isNotEmpty)
                            GParagraphNormal(profileData["jobTitle"] ?? "", color: bodyTextDark),
                        ],
                      ),
                    ],
                  ),
                  const GSizeH(20),
                  Row(
                    children: [
                      if ((profileData["firstName"] ?? "").isNotEmpty)
                        Expanded(flex: 2, child: LabelBodyText("First Name", profileData["firstName"] ?? "")),
                      if ((profileData["firstName"] ?? "").isNotEmpty) const GSizeW(10),
                      if ((profileData["middleName"] ?? "").isNotEmpty)
                        Expanded(flex: 1, child: LabelBodyText("Middle name", profileData["middleName"] ?? "")),
                      if ((profileData["middleName"] ?? "").isNotEmpty) const GSizeW(10),
                      if ((profileData["lastName"] ?? "").isNotEmpty)
                        Expanded(flex: 1, child: LabelBodyText("Last Name", profileData["lastName"] ?? "")),
                      if ((profileData["lastName"] ?? "").isEmpty) const GSizeW(135),
                      if ((profileData["middleName"] ?? "").isEmpty) const GSizeW(145),
                      if ((profileData["firstName"] ?? "").isEmpty) const GSizeW(10),
                    ],
                  ),
                  const GSizeH(10),
                  Row(
                    children: [
                      if ((profileData["jobTitle"] ?? "").isNotEmpty)
                        Expanded(child: LabelBodyText("Job Title", profileData["jobTitle"] ?? "")),
                      // const GSizeW(10),
                      if ((profileData["gender"] ?? "").isNotEmpty)
                        Expanded(child: LabelBodyText("Gender", profileData["gender"] ?? "")),
                    ],
                  ),
                  const GSizeH(10),
                  Row(
                    children: [
                      if ((profileData["birthday"] ?? "").isNotEmpty)
                        Expanded(
                          child: LabelBodyText(
                            "Date of Birth",
                            GDateFunctions.fromateDateFromString(profileData["birthday"] ?? ""),
                          ),
                        ),
                      // GSizeW(10),
                      // if ((profileData["workAnniversary"] ?? "").isNotEmpty)
                      //   Expanded(
                      //     child: LabelBodyText("Work Anniversary", AppFunctions.fromateDateFromString(profileData["workAnniversary"] ?? "")),
                      //   ),
                    ],
                  ),
                  const GSizeH(10),
                  Row(
                    children: [
                      if ((profileData["country"] ?? "").isNotEmpty)
                        Expanded(child: LabelBodyText("Country/Region", (profileData["country"] ?? "").toString())),
                      if ((profileData["timeZone"] ?? "").isNotEmpty)
                        Expanded(child: LabelBodyText("Time Zone", (profileData["timeZone"] ?? "").toString())),
                    ],
                  ),
                  const GSizeH(10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            if (emailsList.isNotEmpty) const LabelBodyText("Email", ""),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: emailsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GBodyText((emailsList[index]["email"] ?? "").toString(), maxLines: 1);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            if (phonesList.isNotEmpty) const LabelBodyText("Phone", ""),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: phonesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GBodyText((phonesList[index]["phoneNo"] ?? "").toString(), maxLines: 1);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
      );
    });
  }
}
