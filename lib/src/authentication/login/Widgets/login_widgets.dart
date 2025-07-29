import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';



Widget title(BuildContext context) {
  return Column(
    children: [
   
      GTextHeading2("Sign In to Your Account"), GSizeH(16),
    ],
  );
}

Widget emailPasswordWidget(BuildContext context) {
  return Obx(
    () => Column(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            // key: LoginController.to.formKey,
            child: Column(
              children: <Widget>[
                if (LoginController.to.checkedValueEmailLogin.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => GLoginEmailField(
                          showheading: true,
                          labelText: "Email",
                          controller: LoginController.to.tecEmail,
                          hintText: "Enter Email",
                          isEnabled: (isLoggingInInvitedUser.isTrue) ? false : true,
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
                      labelText: "Password",
                      controller: LoginController.to.controllerpassword,
                      hintText: "Enter Password",
                      isEnabled: !LoginController.to.loogingIn.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          LoginController.to.passwordVisible.value ? BootstrapIcons.eye : BootstrapIcons.eye_slash,
                          color: Colors.green,
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
                        // if (LoginController.to.formKey.currentState!.validate()) {
                        //   LoginController.to.login(context);
                        // }
                      },
                      // validator: (value) {
                      //   if (value.length < 2) {
                      //     return T("login_Password_should_be_minimum");
                      //   }
                      //   LoginController.to.formKey.currentState!.save();
                      //   return null;
                      // },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: secondaryColorOrange,
                              value: LoginController.to.checkedValue.value,
                              splashRadius: 0,
                              side: BorderSide(color: borderColor, width: 2),
                              onChanged: (value) {
                                // setState(() {
                                LoginController.to.checkedValue.value = !LoginController.to.checkedValue.value;
                                // });
                              },
                            ),
                          ),
                          GSizeW(9),
                          InkWell(
                            onTap: () {
                              // setState(() {
                              LoginController.to.checkedValue.value = !LoginController.to.checkedValue.value;
                              // });
                            },
                            child: Text(
                              "Remember Me",
                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        // onTap: () async {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                        // },
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.w500, color: secondaryColorOrange, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                GSizeH(16),
                (!LoginController.to.loogingIn.value)
                    ? _submitButton(context)
                    : _submitButtonProcess(context),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _submitButton(BuildContext context) {
  return InkWell(
    onTap: () {
      // _showMyDialogLoader("");
      // if (LoginController.to.formKey.currentState!.validate()) {
      LoginController.to.login(context);
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
      child: Text(
        "Login",
        style: TextStyle(fontWeight: FontWeight.w700, color: whiteColor, fontSize: 18),
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
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2),
      ],
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
        Text(
          "Don't have a Global365 Account?",
          style: GAppStyle.style14w500(color: titleColor),
        ),
        GSizeW(4),
        InkWell(
          onTap: () {
            // logEvent("ClickOnRegister", {});

            isFirstpurchase = true;
            // AutoRouter.of(context).push(const PaymentPlanRoute());
            // GNav.pushNav(context, GRouteConfig.signUpScreenRoute);
            GNav.pushNav(context, GRouteConfig.paymentPlanRoute);

            // Modular.to.pushNamed("/Pricing");
            // Modular.to.pushNamed("/SubscriptionPlans");
          },
          child: Text(
            "Sign Up Now",
            style: GAppStyle.style14w500(color: secondaryColorOrange) ,
          ),
        ),
      ],
    ),
  );
}
