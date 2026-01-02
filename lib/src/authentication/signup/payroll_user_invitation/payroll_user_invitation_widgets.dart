import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/authentication/signup/payroll_user_invitation/payroll_user_invitation_controller.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:pinput/pinput.dart';

PayrollUserInvitationController userInvitationController = Get.find();
SignUpController signUpController = Get.isRegistered<SignUpController>() ? Get.find() : Get.put(SignUpController());
Widget signUpAndAcceptWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      userInvitationController.isUserVerifiedNull.value == null
          ? const Column(
              children: [
                Center(child: GTextHeading4("Link is Expired", color: titleColor)),
                SizedBox(height: 30),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: const GTextHeading4("Join our organization", color: titleColor),
                ),
                const GSizeH(8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'We are pleased to invite you to join our organization. To accept this invitation, please create a ',
                          style: GAppStyle.style13w400(color: bodyTextDark),
                        ),
                        TextSpan(
                          text: "Payroll ",
                          style: GAppStyle.style13w600(color: titleColor),
                        ),
                        TextSpan(
                          text: 'account using the email address',
                          style: GAppStyle.style13w400(color: bodyTextDark),
                        ),
                        TextSpan(
                          text: ' ${userInvitationController.invitedUserEmail.value}.',
                          style: GAppStyle.style13w400(color: secondaryColorOrange),
                        ),
                      ],
                    ),
                  ),
                ),
                const GSizeH(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GCustomButton(
                        onTap: () {
                          // alertForRejectConfirmation(context, () {
                          //   if (globals.isUserAlreadyLogedin == true) {
                          //     userInvitationController.isAccepted = false;
                          //     userInvitationController.verifiedUserInvitationResponse(
                          //       context,
                          //       userInvitationController.isAccepted,
                          //     );
                          //   } else {
                          //     userInvitationController.rejectUnVerifiedUser(context);
                          //   }
                          // });
                        },
                        btnText: "Reject",
                        backgroundColor: lightBackgroundColor,
                        textColor: titleColor,
                        bColor: borderColor,
                        extraPadding: true,
                        icon: BootstrapIcons.x_circle_fill,
                      ),
                      userInvitationController.isUserVerified.isFalse
                          ? GCustomButton(
                              onTap: () {
                                gLogger("Sign up & Accept");
                                userInvitationController.pageNumber.value = 1;
                                userInvitationController.functionTOClearDataofSignUp();
                                userInvitationController.tecFirstName.text = userInvitationController.firstNameFromAPI.value;
                                userInvitationController.firstName.value = userInvitationController.firstNameFromAPI.value;
                              },
                              btnText: "Sign up & Accept",
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              bColor: Colors.transparent,
                              extraPadding: true,
                              icon: BootstrapIcons.check_circle_fill,
                            )
                          : isUserAlreadyLogedin == true
                          ? GCustomButton(
                              onTap: () {
                                gLogger("Accept cliecked");
                                userInvitationController.isAccepted = true;
                                userInvitationController.verifiedUserInvitationResponse(
                                  context,
                                  userInvitationController.isAccepted,
                                );
                              },
                              btnText: "Accept",
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              bColor: Colors.transparent,
                              extraPadding: true,
                              icon: BootstrapIcons.check_circle_fill,
                            )
                          : GCustomButton(
                              onTap: () {
                                gLogger("Sign in to Accept 11");
                                LoginController.to.tecEmail.text = userInvitationController.invitedUserEmail.value;

                                // AutoRouter.of(context).replaceAll([const LoginPageUSARoute()]);

                                // context.go(RouteConfig.login);
                              },
                              btnText: "Sign in to Accept",
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              bColor: Colors.transparent,
                              extraPadding: true,
                              icon: BootstrapIcons.check_circle_fill,
                            ),
                    ],
                  ),
                ),
              ],
            ),
    ],
  );
}

Widget signUpWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: const GTextHeading4("Join our organization", color: titleColor),
      ),
      const GSizeH(8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'A new ',
                style: GAppStyle.style13w400(color: bodyTextDark),
              ),
              TextSpan(
                text: "Payroll ",
                style: GAppStyle.style13w600(color: titleColor),
              ),
              TextSpan(
                text: 'account will be created for the email address',
                style: GAppStyle.style13w400(color: bodyTextDark),
              ),
              TextSpan(
                text: ' ${userInvitationController.invitedUserEmail.value}.',
                style: GAppStyle.style13w400(color: secondaryColorOrange),
              ),
            ],
          ),
        ),
      ),
      const GSizeH(10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: GTextFieldForSingleLine(
                onChange: (val) {
                  userInvitationController.firstName.value = userInvitationController.tecFirstName.text.trim();
                  userInvitationController.isFilledAllData.value =
                      (userInvitationController.firstName.value.isNotEmpty &&
                      userInvitationController.password.value.isNotEmpty &&
                      userInvitationController.isPasswordValid.isTrue &&
                      userInvitationController.isAgreedToTerms.value &&
                      userInvitationController.isAgreedToBetaTesting.value);
                },
                controller: userInvitationController.tecFirstName,
                showheading: true,
                labelText: "First Name",
                isRequired: true,
                hintText: "First Name",
              ),
            ),
            const GSizeW(10),
            Expanded(
              child: GTextFieldForSingleLine(
                controller: userInvitationController.tecLastname,
                showheading: true,
                labelText: "Last Name",
                hintText: "Last Name",
              ),
            ),
          ],
        ),
      ),
      const GSizeH(10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: GTextFieldForSingleLine(
          onChange: (val) {
            userInvitationController.password.value = userInvitationController.tecPassword.text.trim();
            userInvitationController.isShowValidation.value = userInvitationController.password.value.isNotEmpty;
            userInvitationController.validatePassword(userInvitationController.password.value);
            userInvitationController.isFilledAllData.value =
                (userInvitationController.firstName.value.isNotEmpty &&
                userInvitationController.password.value.isNotEmpty &&
                userInvitationController.isPasswordValid.isTrue &&
                userInvitationController.isAgreedToTerms.value &&
                userInvitationController.isAgreedToBetaTesting.value);
          },
          controller: userInvitationController.tecPassword,
          isRequired: true,
          showheading: true,
          labelText: "Password",
          hintText: "Password",
          isPassword: userInvitationController.passwordVisible.isFalse,
          suffixIcon: InkWell(
            child: Icon(userInvitationController.passwordVisible.isFalse ? BootstrapIcons.eye_slash : BootstrapIcons.eye),
            onTap: () {
              userInvitationController.passwordVisible.value = !userInvitationController.passwordVisible.value;
            },
          ),
        ),
      ),
      if (userInvitationController.isShowValidation.value && userInvitationController.password.value.isNotEmpty) const GSizeH(10),
      if (userInvitationController.isShowValidation.value && userInvitationController.password.value.isNotEmpty)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  margin: EdgeInsets.only(right: 4),
                  width: 25,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: i < userInvitationController.passwordStrength.value
                        ? (userInvitationController.passwordStrength.value == 1
                              ? Colors.red
                              : userInvitationController.passwordStrength.value == 2
                              ? Colors.orange
                              : Colors.green)
                        : Colors.grey,
                  ),
                ),
              const GSizeW(10),
              Text(
                userInvitationController.passwordStrengthText.value,
                style: TextStyle(
                  fontSize: 12,
                  color: userInvitationController.passwordStrength.value == 1
                      ? Colors.red
                      : userInvitationController.passwordStrength.value == 2
                      ? Colors.orange
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
      const GSizeH(10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
              width: 18,
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: secondaryColorOrange,
                value: userInvitationController.isAgreedToBetaTesting.value,
                splashRadius: 0,
                side: BorderSide(color: lightBackgroundColor, width: 2),
                onChanged: (value) {
                  userInvitationController.isAgreedToBetaTesting.value = !userInvitationController.isAgreedToBetaTesting.value;
                  userInvitationController.isFilledAllData.value =
                      (userInvitationController.firstName.value.isNotEmpty &&
                      userInvitationController.password.value.isNotEmpty &&
                      userInvitationController.isPasswordValid.isTrue &&
                      userInvitationController.isAgreedToTerms.value &&
                      userInvitationController.isAgreedToBetaTesting.value);
                },
              ),
            ),
            GSizeW(9),
            Expanded(
              child: SizedBox(
                // width: 350,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I accept ",
                        style: GAppStyle.style14w600(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            userInvitationController.isAgreedToBetaTesting.value =
                                !userInvitationController.isAgreedToBetaTesting.value;
                            userInvitationController.isFilledAllData.value =
                                (userInvitationController.firstName.value.isNotEmpty &&
                                userInvitationController.password.value.isNotEmpty &&
                                userInvitationController.isPasswordValid.isTrue &&
                                userInvitationController.isAgreedToTerms.value &&
                                userInvitationController.isAgreedToBetaTesting.value);
                          },
                      ),
                      TextSpan(
                        text: "Beta Testing Agreement",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: secondaryColorOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            SignUpController.to.launchURL('https://global365.com/beta-agreement');
                          },
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
              width: 18,
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: secondaryColorOrange,
                value: userInvitationController.isAgreedToTerms.value,
                splashRadius: 0,
                side: BorderSide(color: lightBackgroundColor, width: 2),
                onChanged: (value) {
                  userInvitationController.isAgreedToTerms.value = !userInvitationController.isAgreedToTerms.value;
                  userInvitationController.isFilledAllData.value =
                      (userInvitationController.firstName.value.isNotEmpty &&
                      userInvitationController.password.value.isNotEmpty &&
                      userInvitationController.isPasswordValid.isTrue &&
                      userInvitationController.isAgreedToTerms.value &&
                      userInvitationController.isAgreedToBetaTesting.value);
                },
              ),
            ),
            GSizeW(9),
            Expanded(
              child: SizedBox(
                // width: 350,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I agree to the ",
                        style: GAppStyle.style14w600(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            userInvitationController.isAgreedToTerms.value = !userInvitationController.isAgreedToTerms.value;
                            userInvitationController.isFilledAllData.value =
                                (userInvitationController.firstName.value.isNotEmpty &&
                                userInvitationController.password.value.isNotEmpty &&
                                userInvitationController.isPasswordValid.isTrue &&
                                userInvitationController.isAgreedToTerms.value &&
                                userInvitationController.isAgreedToBetaTesting.value);
                          },
                      ),
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: secondaryColorOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            SignUpController.to.launchURL('https://global365.com/services');
                          },
                      ),
                      TextSpan(text: " and ", style: GAppStyle.style14w600()),
                      TextSpan(
                        text: "Privacy Policy.",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: secondaryColorOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            SignUpController.to.launchURL('https://global365.com/privacyPolicy');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GCustomButton(
              onTap: () {
                gLogger("Back clicked");
                userInvitationController.pageNumber.value = 0;
              },
              btnText: "Back",
              backgroundColor: lightBackgroundColor,
              textColor: titleColor,
              bColor: borderColor,
              extraPadding: true,
              icon: BootstrapIcons.arrow_left_circle_fill,
            ),
            Opacity(
              opacity: userInvitationController.isFilledAllData.isTrue ? 1 : 0.5,
              child: GCustomButton(
                onTap: userInvitationController.isFilledAllData.isFalse
                    ? null
                    : () {
                        gLogger("Sign up ");
                        // userInvitationController.pageNumber.value = 2;
                        // userInvitationController.otp.value = List.filled(6, '');
                        userInvitationController.signUp(context);
                      },
                btnText: "Sign up",
                backgroundColor: primaryColor,
                textColor: Colors.white,
                iconColor: Colors.white,
                bColor: Colors.transparent,
                extraPadding: true,
                icon: BootstrapIcons.check_circle_fill,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget oTPWidget(BuildContext context) {
  PinTheme defaultPinTheme = PinTheme(
    width: 80,
    height: 60,
    padding: const EdgeInsets.only(top: 10, left: 17, right: 17, bottom: 9),
    textStyle: GAppStyle.style18w700(),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: borderColor),
    ),
  );
  return Column(
    children: [
      const GTextHeading3("Verify OTP", color: titleColor),
      const GSizeH(10),
      const GTextHeading6("We have sent a verification code to your email address.", color: bodyText),
      const GTextHeading6("Please enter it here", color: bodyText),
      const GSizeH(40),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Pinput(
          controller: userInvitationController.otpController,
          focusNode: userInvitationController.otpFocusNode,

          isCursorAnimationEnabled: true,
          animationCurve: Curves.bounceIn,
          autofocus: true,

          closeKeyboardWhenCompleted: false,
          focusedPinTheme: defaultPinTheme.copyDecorationWith(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(6),
          ),

          length: 6,
          cursor: Container(
            width: 12,
            height: 4,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: primaryColor),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          defaultPinTheme: defaultPinTheme,
          validator: (value) {
            if (value == null || value.length < 6) {
              return 'Enter a valid OTP';
            }
            return null;
          },
          onChanged: (value) {
            userInvitationController.isButtonEnabled.value = value.length == 6;
          },
          onCompleted: (pin) => gLogger('Completed with pin $pin'),
        ),
      ),

      SizedBox(height: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const GTextHeading5("Didn't get a code?", color: Color(0xff89999F)),
          InkWell(
            onTap: () {
              userInvitationController.resendOTP(context);
            },
            child: const GTextHeading5(' Click to resend', color: secondaryColorOrange),
          ),
        ],
      ),
      const GSizeH(20),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GCustomButton(
              onTap: () {
                gLogger("Back clicked");
                userInvitationController.pageNumber.value = 1;
              },
              btnText: "Back",
              backgroundColor: lightBackgroundColor,
              textColor: titleColor,
              bColor: borderColor,
              extraPadding: true,
              icon: BootstrapIcons.arrow_left_circle_fill,
            ),
            Obx(
              () => Opacity(
                opacity: userInvitationController.isButtonEnabled.value ? 1 : 0.5,
                child: GCustomButton(
                  onTap: userInvitationController.isButtonEnabled.value
                      ? () {
                          userInvitationController.confirmVerificationCode(context);
                          // gLogger("Verify and accept Clicekd ${userInvitationController.otp}");
                        }
                      : null,
                  btnText: "Verify & Accept",
                  backgroundColor: userInvitationController.isButtonEnabled.value ? primaryColor : lightBackground2,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  bColor: Colors.transparent,
                  extraPadding: true,
                  icon: BootstrapIcons.check_circle_fill,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

alertForRejection(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                height: MediaQuery.of(context).size.height / 4,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: const BorderSide(color: borderColor),
                    top: const BorderSide(color: borderColor),
                    right: const BorderSide(color: borderColor),
                    bottom: BorderSide(width: 1, color: borderColor),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(mainAxisAlignment: MainAxisAlignment.center, children: [GTextHeading3("Invitation Rejected")]),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GCustomButton(
                          onTap: () {
                            isLoggingInInvitedUser.value = false;
                            // AutoRouter.of(context).replaceAll([const LoginPageUSARoute()]);

                            // context.go(RouteConfig.login);
                          },
                          btnText: "Ok",
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          bColor: Colors.transparent,
                          extraPadding: true,
                          icon: BootstrapIcons.check_circle_fill,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
