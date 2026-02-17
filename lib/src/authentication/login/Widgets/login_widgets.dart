import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/logger.dart';

// Helper function to get the sign-up redirect URL
String _getSignUpRedirectURL(G365Module module, String environment) {
  final env = environment.toLowerCase();

  switch (module) {
    case G365Module.payroll:
      switch (env) {
        case "development":
          return "https://global365-sso.netlify.app/redirectFromWebsite?moduleName=Payroll";
        case "production":
          return "https://myhub.global365.com/redirectFromWebsite?moduleName=Payroll";
        case "staging":
          return "https://global365-myhub-sit.netlify.app/redirectFromWebsite?moduleName=Payroll";
        default:
          return "https://global365-sso.netlify.app/redirectFromWebsite?moduleName=Payroll";
      }

    case G365Module.merchant:
      switch (env) {
        case "development":
          return "https://global365-sso.netlify.app/redirectFromWebsite?moduleName=Merchant";
        case "production":
          return "https://myhub.global365.com/redirectFromWebsite?moduleName=Merchant";
        case "staging":
          return "https://global365-myhub-sit.netlify.app/redirectFromWebsite?moduleName=Merchant";
        default:
          return "https://global365-sso.netlify.app/redirectFromWebsite?moduleName=Merchant";
      }

    case G365Module.accounting:
      switch (env) {
        case "development":
          return "https://global365-sso.netlify.app/redirectFromWebsite?moduleName=Accounting";
        case "production":
          return "https://myhub.global365.com/redirectFromWebsite?moduleName=Accounting";
        case "staging":
          return "https://global365-myhub-sit.netlify.app/redirectFromWebsite?moduleName=Accounting";
        default:
          return "https://global365-sso.netlify.app/redirectFromWebsite?moduleName=Accounting";
      }

    case G365Module.employeePortal:
      // employeePortal uses internal payment plan route
      return "";
    case G365Module.contractorPortal:
      // contractorPortal uses internal payment plan route
      return "";
  }
}

Widget title(BuildContext context) {
  return Column(children: [GTextHeading2("Sign In to Your Account"), GSizeH(16)]);
}

Widget emailPasswordWidget(BuildContext context) {
  return Obx(
    () => Column(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            // key: LoginController.to.formKey,
            child: AutofillGroup(
              child: Column(
                children: <Widget>[
                  if (LoginController.to.checkedValueEmailLogin.value)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => GLoginEmailField(
                            showheading: true,
                            autofillHints: [AutofillHints.email],
                            labelText: "Email",
                            controller: LoginController.to.tecEmail,
                            focusNode: LoginController.to.emailFocusNode,
                            hintText: "Enter Email",
                            isEnabled: (isLoggingInInvitedUser.isTrue) ? false : true,
                            onFieldSubmitted: (_) => LoginController.to.passwordFocusNode.requestFocus(),
                          ),
                        ),
                        GSizeH(16),
                      ],
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!LoginController.to.checkedValueEmailLogin.value)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone No",
                              style: TextStyle(fontWeight: FontWeight.w700, color: titleColor, fontSize: 14),
                            ),
                            const GSizeH(6),
                          ],
                        ),
                      GLoginEmailField(
                        showheading: true,
                        autofillHints: [AutofillHints.password],
                        labelText: "Password",
                        controller: LoginController.to.controllerpassword,
                        focusNode: LoginController.to.passwordFocusNode,
                        hintText: "Enter Password",
                        isEnabled: !LoginController.to.loogingIn.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            LoginController.to.passwordVisible.value ? BootstrapIcons.eye : BootstrapIcons.eye_slash,
                            color: Colors.green, // Consider changing to primaryColor for consistency
                          ),
                          alignment: Alignment.centerLeft,
                          iconSize: 16,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            LoginController.to.passwordVisible.value = !(LoginController.to.passwordVisible.value);
                          },
                        ),
                        isPassword: LoginController.to.passwordVisible.value,
                        onFieldSubmitted: (value) {
                          LoginController.to.login(context);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            LoginController.to.checkedValue.value = !LoginController.to.checkedValue.value;
                          },
                          focusNode: LoginController.to.rememberMeFocusNode,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: ExcludeFocus(
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: secondaryColorOrange,
                                    value: LoginController.to.checkedValue.value,
                                    splashRadius: 0,
                                    side: BorderSide(color: borderColor, width: 2),
                                    onChanged: (value) {
                                      LoginController.to.checkedValue.value = !LoginController.to.checkedValue.value;
                                    },
                                  ),
                                ),
                              ),
                              GSizeW(9),
                              Text(
                                "Remember Me",
                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          focusNode: LoginController.to.forgotPasswordFocusNode,
                          onTap: () async {
                            Logger.log("FORGOT PASSWORD CLICKED");
                            if (g365Module == G365Module.payroll || g365Module == G365Module.employeePortal || g365Module == G365Module.contractorPortal) {
                              GNav.pushNav(context, GRouteConfig.forgotPassword);
                            }
                          },
                          child: AnimatedBuilder(
                            animation: LoginController.to.forgotPasswordFocusNode,
                            builder: (context, child) {
                              final hasFocus = LoginController.to.forgotPasswordFocusNode.hasFocus;
                              return Container(
                                decoration: hasFocus
                                    ? BoxDecoration(
                                        border: Border(bottom: BorderSide(color: secondaryColorOrange, width: 1)),
                                      )
                                    : null,
                                child: Text(
                                  "Forgot Password",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.w500, color: secondaryColorOrange, fontSize: 14),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  GSizeH(16),
                  (!LoginController.to.loogingIn.value) ? _submitButton(context) : _submitButtonProcess(context),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _submitButton(BuildContext context) {
  return InkWell(
    focusNode: LoginController.to.loginButtonFocusNode,
    onTap: () {
      LoginController.to.login(context);
    },
    child: AnimatedBuilder(
      animation: LoginController.to.loginButtonFocusNode,
      builder: (context, child) {
        final hasFocus = LoginController.to.loginButtonFocusNode.hasFocus;
        return Container(
          height: 48,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: hasFocus
                ? <BoxShadow>[
                    BoxShadow(color: secondaryColorOrange.withOpacity(0.2), offset: Offset(0, 0), blurRadius: 8, spreadRadius: 1),
                  ]
                : <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 1)],
            color: mainColorPrimary,
            border: hasFocus ? Border.all(color: secondaryColorOrange, width: 1) : null,
          ),
          child: Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.w700, color: whiteColor, fontSize: 18),
          ),
        );
      },
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

Widget createAccountLabel(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 16),
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Don't have a Global365 Account?", style: GAppStyle.style14w500(color: titleColor)),
        GSizeW(4),
        InkWell(
          focusNode: LoginController.to.signUpFocusNode,
          onTap: () {
            isFirstpurchase = true;
            // if (g365Module == G365Module.payroll) {
            //   final redirectURL = _getSignUpRedirectURL(g365Module, applicationEnviroment);
            //   LoginController.to.launchURL(redirectURL);
            // } else {
            GNav.pushNav(context, GRouteConfig.paymentPlanRoute);
            // }

            // if (g365Module == G365Module.merchant) {
            //   if (applicationEnviroment.toLowerCase() == "development") {
            //     LoginController.to.launchURL("https://global365-sso.netlify.app/merchantSubscriptionPlan");
            //   } else if (applicationEnviroment.toLowerCase() == "production") {
            //     LoginController.to.launchURL("https://myhub.global365.com/redirectFromWebsite?moduleName=Merchant");
            //   } else {
            //      LoginController.to.launchURL("https://global365-sso.netlify.app/merchantSubscriptionPlan");
            //   }
            // } else if (g365Module == G365Module.payroll) {
            //   if (applicationEnviroment.toLowerCase() == "development") {
            //     LoginController.to.launchURL("https://global365-sso.netlify.app/payrollSubscriptionPlan");
            //   } else if (applicationEnviroment.toLowerCase() == "production") {
            //     LoginController.to.launchURL("https://myhub.global365.com/redirectFromWebsite?moduleName=Payroll");
            //   } else {
            //     LoginController.to.launchURL("https://global365-sso.netlify.app/payrollSubscriptionPlan");
            //   }
            // } else {}

            // Modular.to.pushNamed("/Pricing");
            // Modular.to.pushNamed("/SubscriptionPlans");
          },
          child: AnimatedBuilder(
            animation: LoginController.to.signUpFocusNode,
            builder: (context, child) {
              final hasFocus = LoginController.to.signUpFocusNode.hasFocus;
              return Container(
                decoration: hasFocus
                    ? BoxDecoration(
                        border: Border(bottom: BorderSide(color: secondaryColorOrange, width: 1)),
                      )
                    : null,
                child: Text("Sign Up Now", style: GAppStyle.style14w500(color: secondaryColorOrange)),
              );
            },
          ),
        ),
      ],
    ),
  );
}
