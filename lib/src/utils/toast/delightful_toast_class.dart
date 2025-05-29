import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'delightful_toast_card.dart';

class GToast {
  static info(BuildContext context, String msg, {int duration = 2}) {
    return DelightToastBar(
      position: DelightSnackbarPosition.top,
      animationDuration: const Duration(milliseconds: 1100),
      snackbarDuration: Duration(seconds: duration),
      animationCurve: Curves.fastLinearToSlowEaseIn,
      autoDismiss: true,
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 500,
            //  margin: EdgeInsets.only(right: 116),
            // height: 12,
            child: ToastCard(
              leading: const Icon(CupertinoIcons.info_circle_fill, color: Colors.blue, size: 28),
              title: Text(
                "Info",
                style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'SF-Pro', fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                msg,
                style: TextStyle(
                  color: const Color(0xff1c1c1e),
                  fontSize: 15,
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              // color: Color(0xff1c1c1e),
              color: Colors.white,
              highlightColor: Colors.blue.withValues(alpha: 0.15),
            ),
          ),
        );
      },
    ).show(context);
  }

  static succss(String msg, BuildContext context, {int duration = 2}) {
    return DelightToastBar(
      position: DelightSnackbarPosition.top,
      animationDuration: const Duration(milliseconds: 700),
      snackbarDuration: Duration(seconds: duration),
      animationCurve: Curves.fastLinearToSlowEaseIn,
      autoDismiss: true,
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 500,
            //  margin: EdgeInsets.only(right: 116),
            // height: 12,
            child: ToastCard(
              leading: const Icon(CupertinoIcons.check_mark_circled, color: Colors.green, size: 28),
              title: Text(
                "Success",
                style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'SF-Pro', fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                msg,
                style: TextStyle(
                  color: const Color(0xff1c1c1e),
                  fontSize: 15,
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              // color: Color(0xff1c1c1e),
              color: Colors.white,
              highlightColor: Colors.green.withValues(alpha: 0.25),
            ),
          ),
        );
      },
    ).show(context);
  }

  static error(String msg, BuildContext context, {int duration = 2}) {
    return DelightToastBar(
      position: DelightSnackbarPosition.top,
      animationDuration: const Duration(milliseconds: 700),
      snackbarDuration: Duration(seconds: duration),
      animationCurve: Curves.fastLinearToSlowEaseIn,
      autoDismiss: true,
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 500,
            //  margin: EdgeInsets.only(right: 116),
            // height: 12,
            child: ToastCard(
              leading: Icon(CupertinoIcons.clear_thick_circled, color: Colors.red.shade700, size: 28),
              title: Text(
                "Error",
                style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'SF-Pro', fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                msg,
                style: TextStyle(
                  color: const Color(0xff1c1c1e),
                  fontSize: 15,
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              // color: Color(0xff1c1c1e),
              color: Colors.white,
              highlightColor: Colors.red.shade700.withValues(alpha: 0.2),
            ),
          ),
        );
      },
    ).show(context);
  }

  static warning(String msg, BuildContext context, {int duration = 2}) {
    return DelightToastBar(
      position: DelightSnackbarPosition.top,
      animationDuration: const Duration(milliseconds: 700),
      snackbarDuration: Duration(seconds: duration),
      animationCurve: Curves.fastLinearToSlowEaseIn,
      autoDismiss: true,
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 500,
            //  margin: EdgeInsets.only(right: 116),
            // height: 12,
            child: ToastCard(
              leading: Icon(CupertinoIcons.info_circle_fill, color: Colors.orange.shade700, size: 28),
              title: Text(
                "Warrnig",
                style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'SF-Pro', fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                msg,
                style: TextStyle(
                  color: const Color(0xff1c1c1e),
                  fontSize: 15,
                  fontFamily: 'SF-Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              // color: Color(0xff1c1c1e),
              color: Colors.white,
              highlightColor: Colors.orange.shade700.withValues(alpha: 0.2),
            ),
          ),
        );
      },
    ).show(context);
  }

  static ready(String msg, {int duration = 2}) {
    return DelightToastBar(
      position: DelightSnackbarPosition.top,
      animationDuration: const Duration(milliseconds: 700),
      snackbarDuration: Duration(seconds: duration),
      animationCurve: Curves.fastLinearToSlowEaseIn,
      autoDismiss: true,
      builder: (context) {
        return ToastCard(
          leading: Icon(CupertinoIcons.info_circle_fill, color: Colors.orange.shade700, size: 28),
          title: Text(
            "Warrnig",
            style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'SF-Pro', fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            msg,
            style: TextStyle(
              color: const Color(0xff1c1c1e),
              fontSize: 15,
              fontFamily: 'SF-Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
          // color: Color(0xff1c1c1e),
          color: Colors.white,
          highlightColor: Colors.orange.shade700.withValues(alpha: 0.2),
        );
      },
    );
  }
}
