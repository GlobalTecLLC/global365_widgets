import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/verify_otp_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final VerifyOtpController controller = Get.put(VerifyOtpController());

  @override
  void initState() {
    super.initState();
    VerifyOtpController.to.isLoading.value = false;
    VerifyOtpController.to.tecOtpController.text = '';
    VerifyOtpController.to.isButtonEnabled.value = false;
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
                AppLogo(height: 50),
                SizedBox(height: 32),
                ContainerWithShadow(
                  // height: 572.h,
                  width: 500,
                  child: SingleChildScrollView(child: Column(children: [createAccountWidget(context, controller)])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createAccountWidget(BuildContext context, VerifyOtpController otpController) {
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
        GTextHeading2("Verify Your Identity"),
        SizedBox(height: 8),
        const GTextHeading5(
          "We have sent a verification code to your email address.\nPlease enter it here",
          textAlign: TextAlign.center,
          color: bodyTextColor,
        ),
        SizedBox(height: 16),

        KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: (event) async {
            if (event is KeyDownEvent) {
              final isControlPressed =
                  event.logicalKey == LogicalKeyboardKey.controlLeft || event.logicalKey == LogicalKeyboardKey.controlRight;
              final isVPressed = event.logicalKey == LogicalKeyboardKey.keyV;

              if (HardwareKeyboard.instance.isControlPressed && isVPressed) {
                final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                if (clipboardData != null && clipboardData.text != null) {
                  final pastedText = clipboardData.text!.replaceAll(RegExp(r'[^0-9]'), '');
                  if (pastedText.length >= 6) {
                    controller.tecOtpController.text = pastedText.substring(0, 6);
                    otpController.isButtonEnabled.value = true;
                  } else if (pastedText.isNotEmpty) {
                    controller.tecOtpController.text = pastedText;
                    otpController.isButtonEnabled.value = pastedText.length == 6;
                  }
                }
              }
            }
          },
          child: Pinput(
            isCursorAnimationEnabled: true,
            animationCurve: Curves.bounceIn,
            autofocus: true,
            controller: controller.tecOtpController,
            closeKeyboardWhenCompleted: false,
            enableIMEPersonalizedLearning: true,
            toolbarEnabled: true,
            focusedPinTheme: defaultPinTheme.copyDecorationWith(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            onChanged: (value) {
              otpController.isButtonEnabled.value = value.length == 6;
            },
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
            onCompleted: (pin) => gLogger('Completed with pin $pin'),
          ),
        ),

        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't get a code?", style: GAppStyle.style15w400(color: bodyText)),
            InkWell(
              onTap: () {
                otpController.resendOTP(context);
              },
              child: Text(' Click to resend', style: GAppStyle.style15w600(color: secondaryColorOrange, isUnderLine: true)),
            ),
          ],
        ),

        GSizeH(32),
        Obx(
          () => otpController.isLoading.value
              ? _submitButtonProcess(context)
              : InkWell(
                  onTap: otpController.isButtonEnabled.value
                      ? () {
                          otpController.verifyOTP(context);
                        }
                      : null,
                  child: Opacity(
                    opacity: otpController.isButtonEnabled.value ? 1 : 0.5,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(color: mainColorPrimary, borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _submitButtonProcess(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
        color: mainColorPrimary,
      ),
      child: SpinKitThreeBounce(color: mainColorSecondry, size: 20),
    );
  }
}
