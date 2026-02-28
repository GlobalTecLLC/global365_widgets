import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/forgot_password/forgot_password_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswodScreen extends StatefulWidget {
  const ForgetPasswodScreen({super.key});

  @override
  State<ForgetPasswodScreen> createState() => _ForgetPasswodScreenState();
}

ForgetPasswodController forgetPasswordController = Get.put(ForgetPasswodController());

class _ForgetPasswodScreenState extends State<ForgetPasswodScreen> {
  @override
  void initState() {
    // TODO: implement initState
    forgetPasswordController.functionToClearData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Stack(
            children: [
              const SigninBackground(),
              Positioned.fill(
                // top: 150.h,
                // left: 685.w,
                // right: 685.w,
                // bottom: 150.h,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AppLogo(height: 50),
                          const GSizeH(32),
                          Obx(
                            () => ContainerWithShadow(
                              child: forgetPasswordController.indexforShowingWidget.value == 1
                                  ? Column(
                                      children: [
                                        GTextHeading3("Forgot Your Password"),
                                        GSizeH(10),
                                        GParagraphNormal(
                                          "No worries, we will send you an OTP at yur entered email.\nThen you can reset password after validation",
                                          color: bodyTextDark,
                                        ),
                                        GSizeH(32),
                                        GLoginEmailField(
                                          autofillHints: const [AutofillHints.email],
                                          showheading: true,
                                          isRequired: true,
                                          labelText: "Email",
                                          controller: forgetPasswordController.tecEmail,
                                          hintText: "Enter Email",
                                        ),
                                        GSizeH(20),
                                        GCustomButton(
                                          customPadding: EdgeInsets.symmetric(vertical: 10),
                                          onTap: () {
                                            forgetPasswordController.sendOTP(context);
                                          },
                                          btnText: "Send OTP",
                                          variant: ButtonVariant.filledPrimary,
                                        ),
                                        GSizeH(20),
                                        GCustomButton(
                                          customPadding: EdgeInsets.symmetric(vertical: 10),

                                          onTap: () {
                                            GNav.popNav(context);
                                          },
                                          btnText: "Back to Login",
                                          // variant: ButtonVariant.filledPrimary,
                                        ),
                                      ],
                                    )
                                  : forgetPasswordController.indexforShowingWidget.value == 2
                                  ? Column(
                                      children: [
                                        const GTextHeading3("Verify OTP", color: titleColor),
                                        const GSizeH(10),
                                        const GParagraphNormal(
                                          "We have sent a verification code to your email address.",
                                          color: bodyText,
                                        ),
                                        const GParagraphNormal("Please enter it here", color: bodyText),
                                        const GSizeH(40),
                                        // CustomPinWidget(
                                        //   controller: forgetPasswordController.otpController,
                                        //   focusNode: forgetPasswordController.otpFocusNode,
                                        //   onSubmitted: () {},
                                        //   onChanged: () {},
                                        // ),
                                        Pinput(
                                          isCursorAnimationEnabled: true,
                                          animationCurve: Curves.bounceIn,
                                          autofocus: true,
                                          controller: forgetPasswordController.otpController,
                                          closeKeyboardWhenCompleted: false,
                                          focusedPinTheme: defaultPinTheme.copyDecorationWith(
                                            border: Border.all(color: primaryColor),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          onChanged: (value) {
                                            forgetPasswordController.isButtonEnabled.value = value.length == 6;
                                          },
                                          length: 6,
                                          cursor: Container(
                                            width: 12,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: primaryColor,
                                            ),
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
                                          onCompleted: (pin) => gLogger('Completed with pin $pin'),
                                        ),

                                        GSizeH(20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GTextHeading5("Didn't get a code?", color: Color(0xff89999F)),
                                            InkWell(
                                              onTap: () {
                                                forgetPasswordController.sendOTP(context);
                                              },
                                              child: GTextHeading5(' Click to resend', color: secondaryColorOrange),
                                            ),
                                          ],
                                        ),
                                        GSizeH(20),
                                        InkWell(
                                          onTap: forgetPasswordController.isButtonEnabled.value
                                              ? () {
                                                  forgetPasswordController.verifyOTP(context);
                                                }
                                              : null,
                                          child: Opacity(
                                            opacity: forgetPasswordController.isButtonEnabled.value ? 1 : 0.5,
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: mainColorPrimary,
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        const GTextHeading3("Reset Your Password", color: titleColor),
                                        GSizeH(10),
                                        const GParagraphNormal("Enter your new password", color: bodyText),
                                        GSizeH(20),
                                        GLoginEmailField(
                                          onChange: (value) {
                                            forgetPasswordController.isShowValidation.value =
                                                forgetPasswordController.tecPasswordController.text.isNotEmpty;
                                            forgetPasswordController.validatePassword(
                                              forgetPasswordController.tecPasswordController.text,
                                            );
                                          },
                                          autofillHints: const [AutofillHints.password],
                                          showheading: true,
                                          labelText: "Password",
                                          controller: forgetPasswordController.tecPasswordController,
                                          hintText: "Enter Password",
                                          isEnabled: !forgetPasswordController.loogingIn.value,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: IconButton(
                                              icon: Icon(
                                                forgetPasswordController.passwordVisible.value
                                                    ? BootstrapIcons.eye
                                                    : BootstrapIcons.eye_slash,
                                                color: Colors.green,
                                              ),
                                              alignment: Alignment.center,
                                              iconSize: 16,
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                forgetPasswordController.passwordVisible.value =
                                                    !(forgetPasswordController.passwordVisible.value);
                                              },
                                            ),
                                          ),
                                          isPassword: forgetPasswordController.passwordVisible.value,
                                          onFieldSubmitted: (value) {},
                                        ),
                                        GSizeH(10),
                                        GLoginEmailField(
                                          autofillHints: const [AutofillHints.password],
                                          showheading: true,
                                          labelText: "Re-enter Password",
                                          controller: forgetPasswordController.tecReenterPasswordController,
                                          hintText: "Enter Password",
                                          isEnabled: !forgetPasswordController.loogingIn.value,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: IconButton(
                                              icon: Icon(
                                                forgetPasswordController.reEnterpasswordVisible.value
                                                    ? BootstrapIcons.eye
                                                    : BootstrapIcons.eye_slash,
                                                color: Colors.green,
                                              ),
                                              alignment: Alignment.center,
                                              iconSize: 16,
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                forgetPasswordController.reEnterpasswordVisible.value =
                                                    !(forgetPasswordController.reEnterpasswordVisible.value);
                                              },
                                            ),
                                          ),
                                          isPassword: forgetPasswordController.reEnterpasswordVisible.value,
                                          onFieldSubmitted: (value) {},
                                        ),
                                        if (forgetPasswordController.isShowValidation.value &&
                                            forgetPasswordController.tecPasswordController.text.isNotEmpty)
                                          GSizeH(10),
                                        if (forgetPasswordController.isShowValidation.value &&
                                            forgetPasswordController.tecPasswordController.text.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 0),
                                            child: Row(
                                              children: [
                                                for (int i = 0; i < 3; i++)
                                                  Container(
                                                    margin: EdgeInsets.only(right: 4),
                                                    width: 25,
                                                    height: 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      color: i < forgetPasswordController.passwordStrength.value
                                                          ? (forgetPasswordController.passwordStrength.value == 1
                                                                ? Colors.red
                                                                : forgetPasswordController.passwordStrength.value == 2
                                                                ? Colors.orange
                                                                : Colors.green)
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                const GSizeW(10),
                                                Text(
                                                  forgetPasswordController.passwordStrengthText.value,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: forgetPasswordController.passwordStrength.value == 1
                                                        ? Colors.red
                                                        : forgetPasswordController.passwordStrength.value == 2
                                                        ? Colors.orange
                                                        : Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        const GSizeH(10),
                                        const GSizeH(20),
                                        GCustomButton(
                                          customPadding: EdgeInsets.symmetric(vertical: 10),
                                          onTap: forgetPasswordController.passwordStrength.value == 1
                                              ? null
                                              : () {
                                                  forgetPasswordController.resetPassword(context);
                                                },
                                          btnText: "Submit",
                                          // variant: ButtonVariant.filledPrimary,
                                          textColor: whiteColor,
                                          backgroundColor: forgetPasswordController.passwordStrength.value == 1
                                              ? primaryColor.withOpacity(0.25)
                                              : primaryColor,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     InkWell(
                          //         onTap: () {
                          //           if (forgetPasswordController.indexforShowingWidget.value > 1) {
                          //             forgetPasswordController.indexforShowingWidget--;
                          //           }
                          //         },
                          //         child: Icon(Icons.drive_file_move_rtl_outlined)),
                          //     SizedW(10),
                          //     InkWell(
                          //         onTap: () {
                          //           if (forgetPasswordController.indexforShowingWidget.value < 3) {
                          //             forgetPasswordController.indexforShowingWidget++;
                          //           }
                          //         },
                          //         child: Icon(Icons.drive_file_move_rtl_outlined))
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GBodyText(
                          "Terms and conditions, features, and pricing are all subject to change without notice.",
                          color: bodyText,
                          textAlign: TextAlign.center,
                        ),
                        GSizeH(12),
                        InkWell(
                          // onTap: () {
                          //   PlanAndBillingController planAndBillingController = Get.put(PlanAndBillingController());

                          //   alertForAddPaymentMethod(
                          //     context,
                          //     planAndBillingController.name,
                          //     planAndBillingController.cardNumber,
                          //     planAndBillingController.cvv,
                          //     planAndBillingController.selectedDateFrom,
                          //     planAndBillingController.tecDateFrom,
                          //     '',
                          //   );
                          // },
                          child: GBodyText(
                            "© ${DateTime.now().year}, Global365 LLC. All Rights Reserved.",
                            color: bodyText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const GSizeH(20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
