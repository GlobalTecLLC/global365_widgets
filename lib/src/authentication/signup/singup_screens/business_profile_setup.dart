import 'package:flutter/material.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
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
import 'package:global365_widgets/src/textfileds/phone_number_text_field.dart';
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
    BusinessProfileController.to.addressValidationMsg.value = '';
    BusinessProfileController.to.selectedLocationId.value = 233;
    BusinessProfileController.to.getStatesData(context);
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

      child: Stack(
        children: [
          const SigninBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppLogo(height: 50),
                SizedBox(height: 32),

                ContainerWithShadow(
                  width: 1000,
                  child: SingleChildScrollView(child: Column(children: [createAccountWidget(context)])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createAccountWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: GTextHeading2("Organization/Business Profile Setup", color: Color(0xff2d2c2c))),
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
                hintText: "Address Line 1",
                isRequired: true,
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
                hintText: "Address Line 2",
                // isDropdownStyle: true,
              ),
            ),
          ],
        ),
        GSizeH(16),

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
                    hintText: "City",
                    fontSizeForLabel: 14.0,
                    maxLine: 1,
                    paddingBelowHeading: 5,
                    fontSizeForAll: 14.0,
                    textFieldColor: Colors.black,
                    isRequired: true,
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
                        isRequired: true,
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
                isRequired: true,
                controller: BusinessProfileController.to.tecZip,
                labelText: 'Zip',
                fontSizeForLabel: 14.0,
                maxLine: 1,
                paddingBelowHeading: 5,
                maxLength: 5,
                fontSizeForAll: 12.0,
                // isDropdownStyle: true,
              ),
            ),
          ],
        ),
        GSizeH(16),
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
                        isRequired: true,
                        label: 'Organization/Business Location',
                        onChanged: (item) {
                          BusinessProfileController.to.statesList.clear();

                          BusinessProfileController.to.selectedLocationId.value = SetUpController.to.locationDropdown.value["id"];
                          BusinessProfileController.to.getStatesData(context);

                          SetUpController.to.updationControllerFunctin();
                          gLogger("LocationId: ${BusinessProfileController.to.selectedLocationId.value}");
                        },
                      ),
              ),

              GSizeW(20),

              Expanded(
                child: GCustomPhoneNumberField(
                  controller: BusinessProfileController.to.phoneController,
                  onChanged: (phoneNumber, countryCode, isValid) {
                    print(
                      'Phone: ${BusinessProfileController.to.phoneController.phoneNumber}, Country: $countryCode, isValid: $isValid',
                    );
                  },
                ),
              ),

              // Expanded(
              //   child: GNumberTextFormField(
              //     containerHeight: 42,
              //     showheading: true,
              //     isRequired: true,
              //     isNumberOnly: true,
              //     numberFormat: true,
              //     hintText: "(000) 000-0000",
              //     labelText: "Company Phone Number",
              //     controller: BusinessProfileController.to.phoneNumber,
              //     textAlign: TextAlign.left,
              //   ),
              // ),
            ],
          ),
        ),

        SizedBox(height: 16),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (BusinessProfileController.to.addressValidationMsg.value.isNotEmpty)
                Text(BusinessProfileController.to.addressValidationMsg.value, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _goBack(context)),
            const Spacer(),
            Expanded(child: _submitButton(context)),
          ],
        ),
      ],
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
        if (SetUpController.to.businessName.text.isEmpty ||
            BusinessProfileController.to.phoneNumber.text.isEmpty
            // BusinessProfileController.to.industryDropdown.value == null ||
            // BusinessProfileController.to.languageDropdown.value == null ||
            // BusinessProfileController.to.stateDropdown.value == null ||
            // BusinessProfileController.to.timezoneDropdown.value == null ||
            // BusinessProfileController.to.address.text.isEmpty ||
            // BusinessProfileController.to.currencyDropdown.value == null
            ||
            BusinessProfileController.to.tecaddressLine1.text.isEmpty ||
            BusinessProfileController.to.tecCity.text.isEmpty ||
            BusinessProfileController.to.tecZip.text.isEmpty ||
            BusinessProfileController.to.stateDropdown.value == null) {
          gLogger(BusinessProfileController.to.tecaddressLine1.text);
          gLogger(BusinessProfileController.to.currencyDropdown.value);
          gLogger(BusinessProfileController.to.industryDropdown.value);
          gLogger(BusinessProfileController.to.languageDropdown.value);
          gLogger(BusinessProfileController.to.stateDropdown.value);
          gLogger(BusinessProfileController.to.timezoneDropdown.value);
          GToast.info(context, "Please enter all details");
        } else {
          final text = BusinessProfileController.to.phoneNumber.text;
          final digitsOnly = text.replaceAll(RegExp(r'[^\d]'), '');
          SetUpController.to.phoneNumberWithoutFormate = digitsOnly;
          BusinessProfileController.to.validateAddress(context);

          // GNav.pushNav(context, GRouteConfig.softwareInfoScreenRoute);
        }
      },
      child: Container(
        height: 48,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
          color: mainColorPrimary,
        ),
        child: GTextHeading4("Next", color: whiteColor),
      ),
    );
  }
}
