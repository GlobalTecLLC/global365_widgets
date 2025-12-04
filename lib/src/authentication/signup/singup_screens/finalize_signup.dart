import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:g365_widgets_user/g365_widgets_user.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/sign_up_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';

class FinalizeSignup extends StatelessWidget {
  const FinalizeSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyData(context));
  }

  Widget bodyData(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        const SigninBackground(),
        Container(height: height, width: width),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(height: 50),
              SizedBox(height: 32),
              ContainerWithShadow(
                width: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GTextHeading2(
                      "Welcome ${SignUpController.to.firstName.text.trim()} ${SignUpController.to.lastName.text.trim()}!",
                     
                    ),
                    SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GAppStyle.style14w500(color: bodyText),
                        children: [
                          TextSpan(text: 'Thank you for selecting Global365 for '),
                          TextSpan(
                            // text: '${SetUpController.to.businessName.text}!',
                            text: 'your business needs!',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          TextSpan(
                            text:
                                '\nWe are here to support you every step of the way. Before you dive in and get overwhelmed, we’d love to show you around to help you navigate the app.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GTextHeading5("Selected Plan:", color: bodyText),
                        GTextHeading5(" Enterprise"),
                        InkWell(
                          onTap: () {
                            // AutoRouter.of(context).push(const LoginPageUSARoute());
                            GNav.pushNav(context, GRouteConfig.loginUsaPageRoute);
                          },
                          child: Text(
                            " Change Plan",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: secondaryColorOrange,
                              decoration: TextDecoration.underline,
                              decorationColor: secondaryColorOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    _submitButton(context),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        // AutoRouter.of(context).push(const LoginPageUSARoute());
                        GNav.pushNav(context, GRouteConfig.loginUsaPageRoute);
                      },
                      child: Text(
                        "No Thanks, I’ll Explore Myself",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: secondaryColorOrange,
                          decoration: TextDecoration.underline,
                          decorationColor: secondaryColorOrange,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: () {},
                      child: GTextHeading5("(We don’t recommend this)", color: titleColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // AutoRouter.of(context).push(const LoginPageUSARoute());
        GNav.pushNav(context, GRouteConfig.loginUsaPageRoute);
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
        child: GTextHeading4("Login Now", color: whiteColor),
      ),
    );
  }
}
