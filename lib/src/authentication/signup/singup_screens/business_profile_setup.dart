import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/business_profile_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/business_location_dropdown.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/industry_dropdown.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/state_dropdown.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/textfileds/my_login_text_field.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class BusinessProfileSetup extends StatefulWidget {
  const BusinessProfileSetup({super.key});

  @override
  State<BusinessProfileSetup> createState() => _BusinessProfileSetupState();
}

class _BusinessProfileSetupState extends State<BusinessProfileSetup> {
  final BusinessProfileController controller = Get.find();
  @override
  void initState() {
    super.initState();
    BusinessProfileController.to.selectedLocationId.value = 233;
    BusinessProfileController.to.getStatesData(context);
    // BusinessProfileController.to.industryDropdown.value = null;
    // BusinessProfileController.to.languageDropdown.value = null;
    // BusinessProfileController.to.stateDropdown.value = null;
    // BusinessProfileController.to.timezoneDropdown.value = null;
    // BusinessProfileController.to.address.text = '';
    // BusinessProfileController.to.currencyName.text = '';
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
      decoration: const BoxDecoration(color: lightBackgroundColor),
      child: Stack(
        children: [
          Container(height: height, width: width, color: lightBackgroundColor),
          Center(
            child: Container(
              // height: 941,
              width: GResponsive.isMobile(context) ? width - 40 : 1114,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2)),
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
      key: BusinessProfileController.to.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GSizeH(80),
          Center(
            child: SizedBox(
              width: 282,
              height: 56,
              child: SvgPicture.asset('assets/svg/countylogo.svg', fit: BoxFit.fill, package: packageName),
            ),
          ),
          GSizeH(16),
          const Center(child: GTextHeading4("Organization/Business Profile Setup", color: Color(0xff2d2c2c))),
          GSizeH(16),
          const Center(child: GTextHeading5("Organizational Details", color: Color(0xff89999b))),
          GSizeH(16),
          //Business Name
          Row(
            children: [
              Expanded(
                child: GLoginEmailField(
                  showheading: true,
                  isRequired: true,
                  labelText: "Organization/Business Display Name",
                  controller: SetUpController.to.businessName,
                  hintText: "Enter Name",
                ),
              ),
              GSizeW(20),
              Expanded(
                child: IndustryDropdown(
                  offset: const Offset(0, 40),
                  isNotHistory: true,
                  controller: BusinessProfileController.to.industryDropdown,
                  label: 'Industry',
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          //Organizational location/address
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GTextFieldForSingleLine(
                  containerHeight: 40,
                  // isExtraHeightField: true,
                  isCustomHeight: true,
                  controller: BusinessProfileController.to.tecaddressLine1,
                  labelText: 'Address Line 1',
                  showheading: true,
                  paddingBelowHeading: 5,
                  maxLine: 1,
                  fontSizeForAll: 12.0,
                  textFieldColor: Colors.black,
                  fontSizeForLabel: 14.0,
                  hintText: "",
                  // isDropdownStyle: true,
                ),
              ),
              GSizeW(20),
              Expanded(
                flex: 1,
                child: GTextFieldForSingleLine(
                  containerHeight: 40,
                  // isExtraHeightField: true,
                  isCustomHeight: true,
                  controller: BusinessProfileController.to.tecaddressLine2,
                  labelText: 'Address Line 2',
                  fontSizeForAll: 12.0,
                  textFieldColor: Colors.black,
                  showheading: true,
                  fontSizeForLabel: 14.0,
                  maxLine: 1,
                  paddingBelowHeading: 5,
                  hintText: "",
                  // isDropdownStyle: true,
                ),
              ),
            ],
          ),
          GSizeH(20),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GTextFieldForSingleLine(
                      containerHeight: 40,
                      // isExtraHeightField: true,
                      isCustomHeight: true,
                      controller: BusinessProfileController.to.tecCity,
                      labelText: 'City',
                      fontSizeForLabel: 14.0,
                      maxLine: 1,
                      paddingBelowHeading: 5,
                      fontSizeForAll: 14.0,
                      textFieldColor: Colors.black,
                      // isDropdownStyle: true,
                    ),
                  ],
                ),
              ),
              GSizeW(20),
              Obx(
                () => Expanded(
                  flex: 1,
                  child: SetUpController.to.isUpdatingCOntroller.isTrue
                      ? Container()
                      : StateDropdown(
                          isNotHistory: true,
                          // containerHeight: 56,
                          offset: const Offset(0, 40),
                          controller: BusinessProfileController.to.stateDropdown,
                          label: 'State',
                        ),
                ),
              ),
              GSizeW(20),

              Expanded(
                  flex: 1,
                  child: GTextFieldForSingleLine(
                    containerHeight: 40,
                    // isExtraHeightField: true,
                    isCustomHeight: true,
                    controller: BusinessProfileController.to.tecZip,
                    labelText: 'Zip',
                    fontSizeForLabel: 14.0,
                    maxLine: 1,
                    paddingBelowHeading: 5,
                    fontSizeForAll: 12.0,
                    // isDropdownStyle: true,
                  ),
                ),
            ],
          ),
          GSizeH(20),
          Obx(
            () => Row(
              children: [
            
                Expanded(
                  flex: 1,
                  child: SetUpController.to.isUpdatingCOntroller.isTrue
                      ? Container()
                      : BusinessLocationDropdown(
                          containerHeight: 42,
                          isNotHistory: true,
                          isEnabled: false,
                          offset: const Offset(0, 40),
                          controller: SetUpController.to.locationDropdown,
                          partyId: SetUpController.to.locationDropdownId,
                          label: 'Organization/Business Location',
                          onChanged: (item) {
                            BusinessProfileController.to.statesList.clear();

                            BusinessProfileController.to.selectedLocationId.value =
                                SetUpController.to.locationDropdown.value["id"];
                            BusinessProfileController.to.getStatesData(context);

                            SetUpController.to.updationControllerFunctin();
                            gLogger("LocationId: ${BusinessProfileController.to.selectedLocationId.value}");
                          },
                        ),
                ),
                   
                GSizeW(20),
                Expanded(
                  child: GLoginEmailField(
                    showheading: true,
                    isRequired: true,
                    labelText: "Company Phone Number",
                    controller: BusinessProfileController.to.phoneNumber,
                    hintText: "Enter Company Phone Number",
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: GTextFieldForSingleLine(
                //     containerHeight: 40,
                //     // isExtraHeightField: true,
                //     isRequired: true,
                //     isCustomHeight: true,
                //     controller: BusinessProfileController.to.phoneNumber,
                //     labelText: 'Company Phone Number',
                //     fontSizeForLabel: 14.0,
                //     maxLine: 1,
                //     paddingBelowHeading: 5,
                //     fontSizeForAll: 12.0,
                //     // isDropdownStyle: true,
                //   ),
                // ),
              ],
            ),
          ),

          SizedBox(height: 44),
          Row(
            children: [
              SizedBox(width: 220, child: _goBack(context)),
              const Spacer(),
              SizedBox(width: 220, child: _submitButton(context)),
            ],
          ),

          GSizeH(80),
        ],
      ).marginSymmetric(horizontal: 80),
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
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffc4d2d8)),
          // boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
          color: lightBackgroundColor,
        ),
        child: const GTextHeading4("Go Back"),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (SetUpController.to.businessName.text.isEmpty || BusinessProfileController.to.phoneNumber.text.isEmpty 
        // BusinessProfileController.to.industryDropdown.value == null ||
        // BusinessProfileController.to.languageDropdown.value == null ||
        // BusinessProfileController.to.stateDropdown.value == null ||
        // BusinessProfileController.to.timezoneDropdown.value == null ||
        // BusinessProfileController.to.address.text.isEmpty ||
        // BusinessProfileController.to.currencyDropdown.value == null
        ) {
          gLogger(BusinessProfileController.to.tecaddressLine1.text);
          gLogger(BusinessProfileController.to.currencyDropdown.value);
          gLogger(BusinessProfileController.to.industryDropdown.value);
          gLogger(BusinessProfileController.to.languageDropdown.value);
          gLogger(BusinessProfileController.to.stateDropdown.value);
          gLogger(BusinessProfileController.to.timezoneDropdown.value);
          GToast.info(context, "Please enter all details");
        } else {
          // AutoRouter.of(context).push(const SoftwareInfoScreenRoute());
          GNav.pushNav(context, GRouteConfig.softwareInfoScreenRoute); 
        }
      },
      child: Container(
        height: 48,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
          ],
          color: mainColorPrimary,
        ),
        child: GTextHeading4("Next", color: whiteColor),
      ),
    );
  }
}
