import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/business_profile_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/sign_up_controller.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/business_location_dropdown.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/textfileds/my_login_text_field.dart';
import 'package:global365_widgets/src/textfileds/usphonenumer_filed.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class SetUpScreen extends StatefulWidget {
  const SetUpScreen({super.key});

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  late final SetUpController controller;

  final BusinessProfileController businessController = Get.put(BusinessProfileController());

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<SignUpController>()) {
      Get.find<SignUpController>();
    } else {
      Get.put(SignUpController());
    }
    if (Get.isRegistered<SetUpController>()) {
      controller = Get.find<SetUpController>();
    } else {
      controller = Get.put(SetUpController());
    }
    BusinessProfileController.to.getLocationsDropDown(context);
    if (!controller.isExistingCompany) {
      controller.businessName.text = '';
    }

    controller.locationDropdown.value = null;
    BusinessProfileController.to.getDropDownsData(context);
    BusinessProfileController.to.industryDropdown.value = null;
    BusinessProfileController.to.languageDropdown.value = null;
    BusinessProfileController.to.stateDropdown.value = null;
    BusinessProfileController.to.timezoneDropdown.value = null;
    BusinessProfileController.to.tecaddressLine1.text = '';
    BusinessProfileController.to.tecaddressLine2.text = '';
    BusinessProfileController.to.tecCity.text = '';
    BusinessProfileController.to.tecZip.text = '';
    BusinessProfileController.to.currencyName.text = '';
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
              // height: 572,
              width: GResponsive.isMobile(context) ? width - 40 : 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color.fromARGB(15, 5, 0, 0), blurRadius: 10, spreadRadius: 5, offset: Offset(2, 2)),
                ],
              ),
              child: SingleChildScrollView(child: Column(children: [createAccountWidget(context, controller)])),
            ),
          ),
       
        ],
      ),
    );
  }

  Widget createAccountWidget(BuildContext context, SetUpController otpController) {
    return Form(
      // key: otpController.formKey,
      child: Column(
        children: [
          GSizeH(80),
          SizedBox(
            width: 282,
            height: 56,
            child: SvgPicture.asset(getModuleLogo(), fit: BoxFit.fill, package: packageName),
          ),
          SizedBox(height: 40),
          GTextHeading2(
            "Welcome ${SignUpController.to.firstName.text} ${SignUpController.to.lastName.text}",
            color: primaryColor,
          ),
          SizedBox(height: 40),
          GLoginEmailField(
            showheading: true,
            labelText: "Organization/Business Display Name",
            isRequired: true,
            controller: controller.businessName,
            hintText: "Enter Name",
          ),
          GSizeH(20),
          if (g365Module == G365Module.merchant)
            USPhoneNumberField(
              controller: controller.phoneNumber,
              hintText: 'Enter your phone number',
              labelText: "Phone Number",
              isRequired: true,
              borderRadius: 5,
              onChanged: (fullNumber) {},
              onSubmitted: (value) {
                // Handle form submission
              },
            ),
          if (g365Module != G365Module.merchant)
          Obx(
            () => SizedBox(
              width: 540,
                child: controller.isUpdatingCOntroller.isTrue
                  ? Container(height: 78)
                  : BusinessLocationDropdown(
                      containerHeight: 56,
                      offset: const Offset(0, 40),
                        controller: controller.locationDropdown,
                        partyId: controller.locationDropdownId,
                      label: 'Organization/Business Location',
                      isNotHistory: true,
                      isUpdate: true,
                      onChanged: (item) {
                        BusinessProfileController.to.statesList.clear();
                        BusinessProfileController.to.selectedLocationId.value =
                              controller.locationDropdown.value["id"];
                        BusinessProfileController.to.getStatesData(context);
                          controller.updationControllerFunctin();
                        gLogger("LocationId: ${BusinessProfileController.to.selectedLocationId.value}");
                      },
                    ),
            ),
          ),
         
          SizedBox(height: 30),
          _submitButton(context),
          GSizeH(80),
        ],
      ).marginSymmetric(horizontal: 80),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        gLogger("Let's get your setup called and ${controller.locationDropdown.value}");
        if (controller.businessName.text.isEmpty) {
          GToast.error("Enter Business Name", context);
        } else if (controller.locationDropdown.value == null && g365Module != G365Module.merchant) {
          GToast.error("Select Bussiness Location", context);
        } else if (controller.phoneNumber.text.length < 14 && g365Module == G365Module.merchant) {
          GToast.error("Enter a valid 10 digit phone number", context);
        } else {
          if (g365Module == G365Module.merchant) {
            Get.put(SoftwareInfoController());
            final text = controller.phoneNumber.text;
            final digitsOnly = text.replaceAll(RegExp(r'[^\d]'), '');
            controller.phoneNumberWithoutFormate = "1$digitsOnly";
            SoftwareInfoController.to.signUp(context);
          } else {
            GNav.pushNav(context, GRouteConfig.businessProfileSetupRoute); 
        }
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
        child: GTextHeading4("Let’s get you setup", color: whiteColor),
      ),
    );
  }
}
