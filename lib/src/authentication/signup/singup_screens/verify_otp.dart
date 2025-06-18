import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/verify_otp_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';

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

  Widget createAccountWidget(BuildContext context, VerifyOtpController otpController) {
    return Obx(
      () => Column(
        children: [
          SizedBox(height: 80),
          SizedBox(
            width: 282,
            height: 56,
            child: SvgPicture.asset(getModuleLogo(), fit: BoxFit.fill, package: packageName),
          ),
          SizedBox(height: 40),
          Text(
            "Verify Your Identity",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, fontSize: 24, color: titleColor,
            ),
          ),
          SizedBox(height: 10),
          const GTextHeading5(
            "We have sent a verification code to your email address.\nPlease enter it here",
            textAlign: TextAlign.center,
            color: bodyTextColor,
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: otpController.otp[index].isEmpty ? borderColor : lightBackgroundColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: TextField(
                    cursorHeight: 30,
                    onChanged: (value) {
                      if (value.length == 1) {
                        otpController.updateOtp(index, value);
                        if (index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      } else if (value.isEmpty) {
                        otpController.updateOtp(index, '');
                        if (index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      }
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(fontSize: 30, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Didn't get a code?", style: GAppStyle.style15w400(color: bodyText)),
              InkWell(
                onTap: () {
                  otpController.resendOTP(context);
                },
                child: Text(
                  ' Click to resend',
                  style: GAppStyle.style15w600(color: secondaryColorOrange, isUnderLine: true),
                ),
              ),
              ],
            ),
          
          GSizeH(44),
          Obx(
            () => otpController.isLoading.value
                ? _submitButtonProcess(context)
                : GestureDetector(
                    onTap: otpController.isButtonEnabled.value
                        ? () {
                            otpController.verifyOTP(context);
                          }
                        : null,
                    child: Opacity(
                      opacity: otpController.isButtonEnabled.value ? 1 : 0.5,
                      child: Container(
                        width: 400,
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
          GSizeH(80),
        ],
      ).marginSymmetric(horizontal: GResponsive.isMobile(context) ? 20 : 80),
    );
  }

  Widget _submitButtonProcess(BuildContext context) {
    return Container(
      height: 48,
      
      width: 400,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
        ],
        color: mainColorPrimary,
      ),
      child: SpinKitThreeBounce(color: mainColorSecondry, size: 20),
    );
  }
}
