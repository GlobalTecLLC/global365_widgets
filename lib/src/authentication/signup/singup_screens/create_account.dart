import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  Future<void> lanchurl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.firstName.text = '';
      controller.lastName.text = '';
      controller.tecEmail.text = '';
      controller.controllerpassword.text = '';
      controller.checkedValue.value = false;
      controller.isLoading.value = false;
      controller.betaTestingAgreement.value = false;
    });
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppLogo(height: 50),
                SizedBox(height: 32),
                ContainerWithShadow(
                  width: 500,

                  // height: 800.h,
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
    return Obx(
      () => Column(
        children: [
          const GTextHeading2("Create Your Account Today"),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GLoginEmailField(
                  showheading: true,
                  labelText: "First Name",
                  isRequired: true,
                  controller: SignUpController.to.firstName,
                  hintText: "First Name",
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter an first name';
                  //   }

                  //   return null;
                  // },
                ),
              ),
              GSizeW(8),
              Expanded(
                child: GLoginEmailField(
                  isRequired: true,
                  showheading: true,
                  labelText: "Last Name",
                  controller: SignUpController.to.lastName,
                  hintText: "Last Name",
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter an last name';
                  //   }

                  //   return null;
                  // },
                ),
              ),
            ],
          ),
          GSizeH(16),
          GLoginEmailField(
            isRequired: true,
            showheading: true,
            labelText: "Email",
            controller: SignUpController.to.tecEmail,
            hintText: "Enter Email",
            onChange: (value) {
              final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              SignUpController.to.isEmailValid.value = emailRegExp.hasMatch(value.trim());
            },
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter an email address';
            //   }
            //   final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
            //   if (!emailRegExp.hasMatch(value)) {
            //     return 'Please enter a valid email address';
            //   }
            //   return null;
            // },
          ),
          GSizeH(16),

          GLoginEmailField(
            isRequired: true,
            showheading: true,
            labelText: "Password",
            controller: SignUpController.to.controllerpassword,
            hintText: "Password",
            suffixIcon: IconButton(
              icon: Icon(
                SignUpController.to.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                color: Colors.green,
              ),
              alignment: Alignment.centerLeft,
              iconSize: 16,
              padding: EdgeInsets.zero,
              onPressed: () {
                SignUpController.to.passwordVisible.value = !(SignUpController.to.passwordVisible.value);
              },
            ),
            isPassword: SignUpController.to.passwordVisible.value,
            onChange: (value) {
              // SignUpController.to.controllerpassword.text = value;
              SignUpController.to.isShowValidation.value = value.isNotEmpty;
              SignUpController.to.validatePassword(value);
            },
          ),
          if (SignUpController.to.isShowValidation.value && SignUpController.to.controllerpassword.text.isNotEmpty) GSizeH(8),

          if (SignUpController.to.isShowValidation.value && SignUpController.to.controllerpassword.text.isNotEmpty)
            Row(
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    width: 25,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: i < SignUpController.to.passwordStrength.value
                          ? (SignUpController.to.passwordStrength.value == 1
                                ? Colors.red
                                : SignUpController.to.passwordStrength.value == 2
                                ? Colors.orange
                                : Colors.green)
                          : Colors.grey,
                    ),
                  ),
                GSizeW(8),

                Text(
                  SignUpController.to.passwordStrengthText.value,
                  style: TextStyle(
                    fontSize: 12,
                    color: SignUpController.to.passwordStrength.value == 1
                        ? Colors.red
                        : SignUpController.to.passwordStrength.value == 2
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
              ],
            ),
          GSizeH(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: secondaryColorOrange,
                  value: SignUpController.to.betaTestingAgreement.value,
                  splashRadius: 0,
                  side: BorderSide(color: lightBackgroundColor, width: 2),
                  onChanged: (value) {
                    // setState(() {
                    SignUpController.to.betaTestingAgreement.value = !SignUpController.to.betaTestingAgreement.value;
                    // });
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
                              SignUpController.to.betaTestingAgreement.value = !SignUpController.to.betaTestingAgreement.value;
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
          GSizeH(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: secondaryColorOrange,
                  value: SignUpController.to.checkedValue.value,
                  splashRadius: 0,
                  side: BorderSide(color: lightBackgroundColor, width: 2),
                  onChanged: (value) {
                    // setState(() {
                    SignUpController.to.checkedValue.value = !SignUpController.to.checkedValue.value;
                    // });
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
                              SignUpController.to.checkedValue.value = !SignUpController.to.checkedValue.value;
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
          SizedBox(height: 16),
          // wrap this condition in obx
          Obx(() => SignUpController.to.isLoading.value ? _submitButtonProcess(context) : _submitButton(context)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have a Global365 account?", style: GAppStyle.style14w500()),
              GSizeW(4),
              InkWell(
                onTap: () {
                  GNav.pushNav(context, GRouteConfig.loginUsaPageRoute);
                },
                child: Text(" Sign In", style: GAppStyle.style14w500(color: secondaryColorOrange)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // gLogger("password: ${SignUpController.to.controllerpassword.text}");
        if (SignUpController.to.firstName.text.isEmpty ||
            SignUpController.to.lastName.text.isEmpty ||
            SignUpController.to.tecEmail.text.isEmpty ||
            SignUpController.to.controllerpassword.text.isEmpty ||
            SignUpController.to.checkedValue.value == false ||
            SignUpController.to.betaTestingAgreement.value == false) {
          GToast.error("Please fill all required fields", context);
        } else if (!SignUpController.to.isEmailValid.value) {
          GToast.error("Please enter a valid email", context);
        } else if (SignUpController.to.isPasswordValid.value == false) {
          GToast.error("Invalid password. Use at least 8 chars, 1 uppercase, 1 number, and 1 symbol.", context);
        } else {
          SignUpController.to.signUp(context);
        }
      },
      child: Opacity(
        opacity:
            (SignUpController.to.firstName.text.isNotEmpty &&
                SignUpController.to.lastName.text.isNotEmpty &&
                SignUpController.to.tecEmail.text.isNotEmpty &&
                SignUpController.to.controllerpassword.text.isNotEmpty &&
                SignUpController.to.checkedValue.value &&
                SignUpController.to.isEmailValid.value &&
                SignUpController.to.betaTestingAgreement.value)
            ? 1.0
            : 0.5,
        child: Container(
          height: 48,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: mainColorPrimary,
          ),
          child: GTextHeading4("Create Account", color: whiteColor),
        ),
      ),
    );
  }

  Widget _submitButtonProcess(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
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
