import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/my_profile_controller.dart';
import 'package:global365_widgets/src/authentication/my_profile/dropdowns/gender_dropdown.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/business_location_dropdown.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/timezone_dropdown.dart';
import 'package:global365_widgets/src/buttons/export_buttons.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class ProfileScreenWidgetEdit extends StatelessWidget {
  ProfileScreenWidgetEdit({super.key});

  MyProfileController myProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 715,
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: lightBackgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFC3D2D7)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GCustomIcon(
                  icon: BootstrapIcons.arrow_left,
                  isFilled: false,
                  size: 28,
                  isOnDark: true,
                  iconColor: primaryColor,
                  onTap: () {
                    myProfileController.isEditProfile.value = false;
                  },
                ),
                const GSizeW(5),
                const GTextHeading5("Personal Information", color: primaryColor),
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
                      () => MyProfileController.to.isUploadingImage.isTrue
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(color: bodyTextDark, borderRadius: BorderRadius.circular(80)),
                              child: SpinKitCircle(color: secondaryColorOrange, size: 20),
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
                                        // FileImage(File(UsersPageController.to.selectedImagePath.value)),
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          MyProfileController.to.pickImage(context);
                          gLogger("Pencil pressed");
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: lightBackgroundColor,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: borderColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: GCustomIcon(
                            svgPath: "assets/icons/usa/pencil.svg",
                            iconOnly: true,
                            size: 14,
                            iconColor: primaryColor,
                          ),
                        ),
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
                      "${myProfileController.tecFirstNameController.text} ${myProfileController.tecLastNameController.text}",
                      color: primaryColor,
                    ),
                    const GSizeH(4),
                    GParagraphNormal(myProfileController.tecJobTitleController.text, color: bodyTextDark),
                  ],
                ),
              ],
            ),
            const GSizeH(20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GTextFieldForSingleLine(
                    isRequired: true,
                    paddingBelowHeading: 0,
                    showheading: true,
                    labelText: "First Name",
                    controller: MyProfileController.to.tecFirstNameController,
                    hintText: "first name",
                  ),
                ),
                const GSizeW(10),
                Expanded(
                  flex: 1,
                  child: GTextFieldForSingleLine(
                    paddingBelowHeading: 0,
                    showheading: true,
                    labelText: "Middle initial",
                    controller: MyProfileController.to.tecMiddleNameController,
                    hintText: "middle initial",
                  ),
                ),
                const GSizeW(10),
                Expanded(
                  flex: 3,
                  child: GTextFieldForSingleLine(
                    isRequired: true,
                    paddingBelowHeading: 0,
                    showheading: true,
                    labelText: "Last Name",
                    hintText: "last name",
                    controller: MyProfileController.to.tecLastNameController,
                  ),
                ),
              ],
            ),
            const GSizeH(10),
            Row(
              children: [
                Expanded(
                  child: GTextFieldForSingleLine(
                    isRequired: true,
                    paddingBelowHeading: 0,
                    showheading: true,
                    labelText: "Job Title",
                    hintText: "Job title",
                    controller: MyProfileController.to.tecJobTitleController,
                  ),
                ),
                const GSizeW(10),
                Expanded(
                  child: Obx(
                    () => myProfileController.isUpdatingDropdown.isTrue
                        ? Container(height: 30)
                        : GenderDropdown(
                            isRequired: true,
                            isNotHistory: true,
                            isUpdate: true,
                            partyId: MyProfileController.to.partyIdForGender,
                            controller: MyProfileController.to.dropdownForGender,
                            label: 'Gender',
                            onChanged: (item) {},
                          ),
                  ),
                ),
              ],
            ),
            const GSizeH(10),
            Row(
              children: [
                Expanded(
                  child: GDateTextFiled(
                    isRequired: true,
                    isShowHeading: true,
                    labelText: "Birthday",
                    selectedDate: MyProfileController.to.selectedDateFromforBirthday,
                    dateController: MyProfileController.to.tecDateFromControllerBirthday,
                  ),
                ),
                // GSizeW(10),
                // Expanded(
                //   child: VPHWebDate(
                //     isShowHeading: true,
                //     labelText: "Work Anniversary",
                //     selectedDateTO: MyProfileController.to.selectedDateToForAniversary,
                //     dateToController: MyProfileController.to.tecdateToControllerforAniversary,
                //     selectedDateFrom: MyProfileController.to.selectedDateFromforAniversary,
                //     dateFromController: MyProfileController.to.tecDateFromControllerAniversary,
                //   ),
                // ),
              ],
            ),
            const GSizeH(10),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => myProfileController.isUpdatingDropdown.isTrue
                        ? Container(height: 30)
                        : BusinessLocationDropdown(
                            isRequired: true,
                            isNotHistory: true,
                            containerHeight: Branding.tFHeight,
                            isUpdate: true,
                            partyId: MyProfileController.to.partyIdForCountryReigon,
                            controller: MyProfileController.to.countryRegionDropDown,
                            label: 'Country/Region',
                            onChanged: (item) {},
                          ),
                  ),
                ),
                const GSizeW(10),
                Expanded(
                  child: Obx(
                    () => myProfileController.isUpdatingDropdown.isTrue
                        ? Container(height: 30)
                        : TimeZoneDropdown(
                            isRequired: true,
                            isNotHistory: true,
                            containerHeight: Branding.tFHeight,
                            isUpdate: true,
                            partyId: MyProfileController.to.partyIdForTimeZone,
                            controller: MyProfileController.to.dropdownForTimezone,
                            label: 'Time Zone',
                          ),
                  ),
                ),
              ],
            ),
            const GSizeH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const GTextHeading6("Email"),
                Text(
                  " *",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.red),
                ),
                const GSizeW(10),

                // if (index == MyProfileController.to.emailList.length - 1)
                GCustomButton(
                  onTap: () {
                    MyProfileController.to.emailList.add({
                      "emailtextFieldController": TextEditingController(),
                      "isPrimary": false,
                      "isVerified": false,
                    });
                  },
                  btnText: "Add Email",
                  isIcon: true,
                  onlyIcon: true,
                  icon: BootstrapIcons.plus_circle_fill,
                ),
                // CustomButton(
                //   onTap: () {
                //     MyProfileController.to.emailList.add({"emailtextFieldController": TextEditingController(), "isPrimary": false, "isVerified": false});
                //   },
                //   customPadding: const EdgeInsets.all(4),
                //   btnText: '',
                //   icon: BootstrapIcons.plus_circle_fill,
                //   variant: ButtonVariant.outlinePrimary,
                //   onlyIcon: true,
                // ),
                //
              ],
            ),

            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: MyProfileController.to.emailList.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GSizeH(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GTextFieldForSingleLine(
                              isRequired: true,
                              showheading: false,
                              controller: MyProfileController.to.emailList[index]["emailtextFieldController"],
                              hintText: "Enter Email",
                            ),
                          ),
                          const GSizeW(5),
                          if ((myProfileController.emailList.isNotEmpty &&
                                  myProfileController.emailList[index]["isPrimary"]) ==
                              false)
                            GCustomButton(
                              onTap: () {
                                if (myProfileController.emailList.length > 1) {
                                  MyProfileController.to.emailList.removeAt(index);
                                } else {
                                  GToast.info(context, "You can't delete the last Email");
                                }
                              },
                              btnText: '',
                              isIcon: true,
                              onlyIcon: true,
                              icon: BootstrapIcons.trash,
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const GSizeH(10),

            // if (MyProfileController.to.emailList.isEmpty)
            //   SaveAndCloseButton(
            //       onTap: () {
            //         MyProfileController.to.emailList.add({"emailtextFieldController": TextEditingController(), "isPrimary": false, "isVerified": false});
            //       },
            //       btnText: "Add Email"),
            // const GSizeH(10),
            // if (MyProfileController.to.phoneList.isEmpty)
            //   SaveAndCloseButton(
            //       onTap: () {
            //         MyProfileController.to.phoneList.add({"phonetextFieldController": TextEditingController(), "isPrimary": false, "isVerified": false});
            //       },
            //       btnText: "Add Phone Number"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const GTextHeading6("Phone"),
                Text(
                  " *",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.red),
                ),
                const GSizeW(10),

                GCustomButton(
                  onTap: () {
                    MyProfileController.to.phoneList.add({
                      "phonetextFieldController": TextEditingController(),
                      "isPrimary": false,
                      "isVerified": false,
                    });
                  },
                  btnText: "Add Phone Number",
                  icon: BootstrapIcons.plus_circle_fill,
                  backgroundColor: primaryColor,
                  isIcon: true,
                  onlyIcon: true,
                  iconColor: Colors.white,
                ),
                // CustomButton(
                //   onTap: () {
                //     MyProfileController.to.phoneList.add({"phonetextFieldController": TextEditingController(), "isPrimary": false, "isVerified": false});
                //   },
                //   customPadding: const EdgeInsets.all(1),
                //   btnText: '',
                //   icon: BootstrapIcons.plus,
                //   variant: ButtonVariant.filledPrimary,
                //   onlyIcon: true,
                // ),
                const GSizeW(5),
              ],
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: MyProfileController.to.phoneList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const GSizeH(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GTextFieldForSingleLine(
                              isRequired: true,
                              showheading: false,
                              isNumberOnly: true,
                              controller: MyProfileController.to.phoneList[index]["phonetextFieldController"],
                              hintText: "Enter Phone Number",
                            ),
                          ),
                          const GSizeW(5),
                          if ((myProfileController.phoneList.isNotEmpty &&
                                  myProfileController.phoneList[index]["isPrimary"]) ==
                              false)
                            GCustomIcon(
                              onTap: () {
                                if (myProfileController.phoneList.length > 1) {
                                  MyProfileController.to.phoneList.removeAt(index);
                                } else {
                                  GToast.info(context, "You can't delete the last phone number");
                                }
                              },
                              icon: BootstrapIcons.trash,
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            Obx(
              () => Column(
                children: [
                  if (myProfileController.phoneList.isEmpty && myProfileController.emailList.isEmpty)
                    const GSizeH(170)
                  else if (myProfileController.phoneList.length == 1 && myProfileController.emailList.length == 1)
                    const GSizeH(160)
                  else if (myProfileController.emailList.length == 2 && myProfileController.phoneList.length == 2)
                    const GSizeH(90)
                  else if (myProfileController.emailList.length == 3 && myProfileController.phoneList.length == 3)
                    const GSizeH(20)
                  else if (myProfileController.emailList.length == 3 && myProfileController.phoneList.length == 2)
                    const GSizeH(55)
                  else if (myProfileController.emailList.length == 2 && myProfileController.phoneList.length == 3)
                    const GSizeH(55)
                  else if (myProfileController.emailList.length == 2 || myProfileController.phoneList.length == 2)
                    const GSizeH(125)
                  else if (myProfileController.emailList.length == 3 || myProfileController.phoneList.length == 3)
                    const GSizeH(90)
                  else
                    const GSizeH(60),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GCustomButton(
                  onTap: () {
                    myProfileController.isEditProfile.value = false;
                  },
                  btnText: "Cancel",
                  backgroundColor: lightBackgroundColor,
                  textColor: titleColor,
                  bColor: borderColor,
                  extraPadding: true,
                ),
                GCustomButton(
                  onTap: () {
                    if (MyProfileController.to.tecFirstNameController.text.isEmpty ||
                        MyProfileController.to.tecLastNameController.text.isEmpty ||
                        MyProfileController.to.phoneList.isEmpty ||
                        MyProfileController.to.emailList.isEmpty) {
                      GToast.error("Please fill all the required fields", context);
                    } else {
                      myProfileController.updateProfileData(context);
                    }
                  },
                  btnText: "Save",
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  bColor: Colors.transparent,
                  extraPadding: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
