
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global365_widgets/src/utils/toast/delight_toast_files/delight_toast.dart';
import 'package:global365_widgets/src/utils/toast/delight_toast_files/toast/utils/enums.dart';


import 'delightful_toast_card.dart';

class GToast {
  //        DelightToastBar(
  //             autoDismiss: false,
  //             builder: (context) => const ToastCard(
  //               leading: Icon(
  //                 Icons.flutter_dash,
  //                 size: 28,
  //               ),
  //               title: Text(
  //                 "Hi I'm Dash, Let's have a walkthrough of Delight Toast",
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //             ),
  //           ).show(context);
  //           setState(() {
  //             onClicked = true;
  //           });
  //           await Future.delayed(const Duration(milliseconds: 300), () {
  //             setState(() {
  //               onClicked = false;
  //             });
  //           });
  static info(BuildContext context, String msg, {int? duration}) {
    int calculatedDuration;
    if (duration == null) {
      if (msg.length < 40) {
        calculatedDuration = 2;
      } else if (msg.length >= 40 && msg.length < 100) {
        calculatedDuration = 4;
      } else if (msg.length >= 100 && msg.length < 250) {
        calculatedDuration = 8;
      } else {
        calculatedDuration = 10;
      }
    } else {
      calculatedDuration = duration;
    }
    return DelightToastBar(
        position: DelightSnackbarPosition.top,
        animationDuration: const Duration(milliseconds: 700),
        snackbarDuration: Duration(seconds: calculatedDuration),
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
                    color1: const Color(0xFFEBF2FD),
                    color2: const Color(0xFFEBF1F9),
                    leading: const Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.blue,
                      size: 28,
                    ),
                    title: "Info",
                    subtitle: msg,
                    // color: Color(0xff1c1c1e),
                    color: Colors.white,
                    highlightColor: Colors.blue.withOpacity(0.15),
                    containerColor: Colors.blue,
                  )));
        }).show(context);
  }

  static succss(String msg, BuildContext context, {int? duration}) {
    int calculatedDuration;
    if (duration == null) {
      if (msg.length < 40) {
        calculatedDuration = 2;
      } else if (msg.length >= 40 && msg.length < 100) {
        calculatedDuration = 4;
      } else if (msg.length >= 100 && msg.length < 250) {
        calculatedDuration = 8;
      } else {
        calculatedDuration = 10;
      }
    } else {
      calculatedDuration = duration;
    }
    return DelightToastBar(
        position: DelightSnackbarPosition.top,
        animationDuration: const Duration(milliseconds: 700),
        snackbarDuration: Duration(seconds: calculatedDuration),
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
                    color1: const Color(0xFFEBF6FA),
                    color2: const Color(0xFFF0F6FA),
                    leading: const Icon(
                      CupertinoIcons.check_mark_circled,
                      color: Colors.green,
                      size: 28,
                    ),
                    title: "Success",
                    subtitle: msg,
                    containerColor: Colors.green,
                    // color: Color(0xff1c1c1e),
                    color: Colors.white,
                    highlightColor: Colors.green.withOpacity(0.25),
                  )));
        }).show(context);
  }

  static error(String msg, BuildContext context, {int? duration}) {
    int calculatedDuration;
    if (duration == null) {
      if (msg.length < 40) {
        calculatedDuration = 2;
      } else if (msg.length >= 40 && msg.length < 100) {
        calculatedDuration = 4;
      } else if (msg.length >= 100 && msg.length < 250) {
        calculatedDuration = 8;
      } else {
        calculatedDuration = 10;
      }
    } else {
      calculatedDuration = duration;
    }
    return DelightToastBar(
        position: DelightSnackbarPosition.top,
        animationDuration: const Duration(milliseconds: 700),
        snackbarDuration: Duration(seconds: calculatedDuration),
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
                color1: const Color(0xFFF4E4EA),
                color2: const Color(0xFFF4EEF4),
                leading: Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Colors.red.shade700,
                  size: 28,
                ),
                title: "Error",
                subtitle: msg,
                containerColor: Colors.red.shade700,
                // color: Color(0xff1c1c1e),
                color: Colors.white,
                highlightColor: Colors.red.shade700.withOpacity(0.2),
              ),
            ),
          );
        }).show(context);
  }

  static warning(String msg, BuildContext context, {int? duration}) {
    int calculatedDuration;
    if (duration == null) {
      if (msg.length < 40) {
        calculatedDuration = 2;
      } else if (msg.length >= 40 && msg.length < 100) {
        calculatedDuration = 4;
      } else if (msg.length >= 100 && msg.length < 250) {
        calculatedDuration = 8;
      } else {
        calculatedDuration = 10;
      }
    } else {
      calculatedDuration = duration;
    }
    return DelightToastBar(
        position: DelightSnackbarPosition.top,
        animationDuration: const Duration(milliseconds: 700),
        snackbarDuration: Duration(seconds: calculatedDuration),
        animationCurve: Curves.fastLinearToSlowEaseIn,
        autoDismiss: true,
        builder: (context) {
          return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 500,
                  child: ToastCard(
                    color1: const Color(0xFFF5EDEC),
                    color2: const Color(0xFFF6F2F3),
                    leading: Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.orange.shade700,
                      size: 28,
                    ),
                    title: "Warning",
                    subtitle: msg,
                    // color: Color(0xff1c1c1e),
                    containerColor: Colors.orange.shade700,
                    color: Colors.white,
                    highlightColor: Colors.orange.shade700.withOpacity(0.2),
                  )));
        }).show(context);
    // showOverlay((context, t) {
    //   return Opacity(
    //     opacity: t,
    //     child: ToastWidget(
    //         msg: msg,
    //         color: Colors.red.shade300,
    //         txtcolor: Colors.white,
    //         icon: Icons.dangerous_outlined),
    //   );
    // });
  }

  static ready(String msg, {int? duration}) {
    int calculatedDuration;
    if (duration == null) {
      if (msg.length < 40) {
        calculatedDuration = 2;
      } else if (msg.length >= 40 && msg.length < 100) {
        calculatedDuration = 4;
      } else if (msg.length >= 100 && msg.length < 250) {
        calculatedDuration = 8;
      } else {
        calculatedDuration = 10;
      }
    } else {
      calculatedDuration = duration;
    }
    return DelightToastBar(
        position: DelightSnackbarPosition.top,
        animationDuration: const Duration(milliseconds: 700),
        snackbarDuration: Duration(seconds: calculatedDuration),
        animationCurve: Curves.fastLinearToSlowEaseIn,
        autoDismiss: true,
        builder: (context) {
          return ToastCard(
            color1: const Color(0xFFF5EDEC),
            color2: const Color(0xFFF6F2F3),
            leading: Icon(
              CupertinoIcons.info_circle_fill,
              color: Colors.orange.shade700,
              size: 28,
            ),
            title: "Warrning",
            subtitle: msg,
            // color: Color(0xff1c1c1e),
            containerColor: Colors.orange.shade700,
            color: Colors.white,
            highlightColor: Colors.orange.shade700.withOpacity(0.2),
          );
        });
    // showOverlay((context, t) {
    //   return Opacity(
    //     opacity: t,
    //     child: ToastWidget(
    //         msg: msg,
    //         color: Colors.red.shade300,
    //         txtcolor: Colors.white,
    //         icon: Icons.dangerous_outlined),
    //   );
    // });
  }
  // static info(String msg) {
  //   showOverlay((context, t) {
  //     return Opacity(
  //       opacity: t,
  //       child: ToastWidget(
  //           msg: msg,
  //           color: Colors.blue,
  //           txtcolor: Colors.white,
  //           icon: Icons.info),
  //     );
  //   });
  // }
}
