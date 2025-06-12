import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/sign_up_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class FinalizeSignup extends StatelessWidget {
  const FinalizeSignup({super.key});

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
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/imgs/finalize_signup.png"))),
      child: Column(
        children: [
          SizedBox(height: 140),
          SizedBox(width: 282, height: 56, child: SvgPicture.asset('assets/svg/countylogo.svg', fit: BoxFit.fill)),
          SizedBox(height: 55),
          Text(
            "Welcome ${SignUpController.to.firstName.text} ${SignUpController.to.lastName.text}!",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 26,
              color: const Color(0xff2d2c2c),
            ),
          ),
          SizedBox(height: 18),
          SizedBox(
            width: 650,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GAppStyle.style14w600(color: titleColor),
                children: [
                  TextSpan(text: 'Thank you for selecting Global365 for '),
                  TextSpan(
                    text: '${SetUpController.to.businessName.text}!',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        '\nWe are here to support you every step of the way. Before you dive in and get overwhelmed, we’d love to show you around to help you navigate the app.',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GTextHeading5("Selected Plan:", color: const Color(0xff89999f)),
              GTextHeading5(" Enterprise"),
              InkWell(
                onTap: () {
                  // AutoRouter.of(context).push(const LoginPageUSARoute());
                  // GNav.pushNav(context, RouteConfig.loginUsaPageRoute); TODO:
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
          SizedBox(height: 50),
          SizedBox(width: 540, child: _submitButton(context)),
          SizedBox(height: 11),
          InkWell(
            onTap: () {
              // AutoRouter.of(context).push(const LoginPageUSARoute());
              // GNav.pushNav(context, RouteConfig.loginUsaPageRoute); TODO:
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
          SizedBox(height: 5),
          InkWell(
            onTap: () {},
            child: GTextHeading5("(We don’t recommend this)", color: titleColor),
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // AutoRouter.of(context).push(const LoginPageUSARoute());
        // GNav.pushNav(context, RouteConfig.loginUsaPageRoute); TODO:
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
