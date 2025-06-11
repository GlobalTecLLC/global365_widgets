import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/business_profile_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/sign_up_controller.dart';
import 'package:global365_widgets/src/authentication/signup/dropdowns/business_location_dropdown.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/textfileds/my_login_text_field.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class SetUpScreen extends StatefulWidget {
  const SetUpScreen({super.key});

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  final SetUpController controller = Get.put(SetUpController());

  final BusinessProfileController businessController = Get.put(BusinessProfileController());

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<SignUpController>()) {
      Get.find<SignUpController>();
    } else {
      Get.put(SignUpController());
    }
    BusinessProfileController.to.getLocationsDropDown(context);
    SetUpController.to.businessName.text = '';
    SetUpController.to.locationDropdown.value = null;
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
          // Positioned(
          //   top: height / 1.28,
          //   left: width / 2.3,
          //   child: Row(
          //     children: [
          //       Text(
          //         "Already have an account?",
          //         style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16, color: whiteColor),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           AutoRouter.of(context).push(const LoginPageUSARoute());
          //         },
          //         child: Text(
          //           " Login here",
          //           style: TextStyle(
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.w600,
          //               fontSize: 16,
          //               color: secondaryColorOrange,
          //               decoration: TextDecoration.underline,
          //               decorationColor: secondaryColorOrange),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
          SizedBox(width: 282, height: 56, child: SvgPicture.asset('assets/imgs/countylogo.svg', fit: BoxFit.fill)),
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
            controller: SetUpController.to.businessName,
            hintText: "Enter Name",
          ),
          GSizeH(20),
          Obx(
            () => SizedBox(
              width: 540,
              child: SetUpController.to.isUpdatingCOntroller.isTrue
                  ? Container(height: 78)
                  : BusinessLocationDropdown(
                      containerHeight: 56,
                      offset: const Offset(0, 40),
                      controller: SetUpController.to.locationDropdown,
                      partyId: SetUpController.to.locationDropdownId,
                      label: 'Organization/Business Location',
                      isNotHistory: true,
                      isUpdate: true,
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
        gLogger("Let's get your setup called and ${SetUpController.to.locationDropdown.value}");
        if (SetUpController.to.businessName.text.isEmpty) {
          GToast.error("Enter Business Name", context);
        } else if (SetUpController.to.locationDropdown.value == null) {
          GToast.error("Select Bussiness Location", context);
        } else {
          // AutoRouter.of(context).push(const BusinessProfileSetupRoute());
          // GNav.pushNav(context, RouteConfig.businessProfileSetupRoute); TODO:
        }
        // _showMyDialogLoader("");
        // if (SetUpController.to.formKey.currentState!.validate()) {
        //   AutoRouter.of(context).push(const BusinessProfileSetupRoute());
        // }

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => DashBoard()));
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
