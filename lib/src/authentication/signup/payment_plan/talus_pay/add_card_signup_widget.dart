/////////////////////////////////////////////////////////////////////////
// using inappwebview package
////////////////////////////////////////////////////////////////////////

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/payment_info_controller.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class AddCardSignUpWidget extends StatefulWidget {
  const AddCardSignUpWidget({super.key});

  @override
  State<AddCardSignUpWidget> createState() => _AddCardSignUpWidgetState();
}

class _AddCardSignUpWidgetState extends State<AddCardSignUpWidget> {
  // late InAppWebViewController controller;
  final controller = Get.isRegistered<PaymentInfoController>()
      ? Get.find<PaymentInfoController>()
      : Get.put(PaymentInfoController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          GTextFieldForSingleLine(
            controller: controller.cardCardNumber,
            focusNode: controller.cardCardNumberFocusNode,
            labelText: 'Card Number',
            hintText: "xxxx-xxxx-xxxx-xxxx",
            maxLine: 1,
            isRequired: true,
            cardNumber: true,
            onFieldSubmitted: (_) => controller.cardExpiryFocusNode.requestFocus(),
          ),
          GSizeH(12),
          Row(
            children: [
              Expanded(
                child: GTextFieldForSingleLine(
                  controller: controller.cardExpiry,
                  focusNode: controller.cardExpiryFocusNode,
                  labelText: "Expiry",
                  maxLine: 1,
                  hintText: "MM/YY",
                  isRequired: true,
                  cardExpiry: true,
                  onFieldSubmitted: (_) => controller.cardCCVFocusNode.requestFocus(),
                ),
              ),
              const GSizeW(12),
              Expanded(
                child: GTextFieldForSingleLine(
                  controller: controller.cardCCV,
                  focusNode: controller.cardCCVFocusNode,
                  labelText: "CVV",
                  hintText: "XXX",
                  maxLine: 1,
                  isRequired: true,
                  cvvNumber: true,
                  onFieldSubmitted: (_) => controller.proceedButtonFocusNode.requestFocus(),
                ),
              ),
            ],
          ),
          GSizeH(12),
          InkWell(
            focusNode: controller.proceedButtonFocusNode,
            onTap: () {
              controller.submitPaymentInfo(context);
            },
            child: AnimatedBuilder(
              animation: controller.proceedButtonFocusNode,
              builder: (context, child) {
                final hasFocus = controller.proceedButtonFocusNode.hasFocus;
                return Container(
                  height: 48,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: hasFocus
                        ? <BoxShadow>[
                            BoxShadow(
                              color: secondaryColorOrange.withOpacity(0.2),
                              offset: Offset(0, 0),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : <BoxShadow>[
                            BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 1),
                          ],
                    color: mainColorPrimary,
                    border: hasFocus ? Border.all(color: secondaryColorOrange, width: 1) : null,
                  ),
                  child: GTextHeading4("Proceed", color: whiteColor),
                );
              },
            ),
          ),
        ],
      ),

      // Old webview component
      //   (kIsWeb)
      //       ? WebViewWebPayment(
      //           isSignUp: true,
      //         )
      //       : InAppWebView(
      //           initialData: InAppWebViewInitialData(
      //             data: PaymentProcessing.getHTMLString(btnText: "Proceed"),
      //           ),
      //           initialSettings: InAppWebViewSettings(
      //             javaScriptEnabled: true,
      //             allowUniversalAccessFromFileURLs: true,
      //             allowFileAccessFromFileURLs: true,
      //           ),
      //           onWebViewCreated: (controller) {
      //             printLog("WebView created123");
      //             controller = controller;
      //           },
      //           onLoadStart: (controller, url) {
      //             printLog("on load start");
      //           },
      //           onLoadStop: (controller, url) async {
      //             printLog("on load stop");
      //           },
      //           onNavigationResponse: (controller, navigationResponse) async {
      //             printLog("Navigation Response: ${navigationResponse.response?.statusCode}");
      //             return NavigationResponseAction.CANCEL;
      //           },
      //           onConsoleMessage: (controller, consoleMessage) {
      //              PaymentMethodService.onSubmissionOfPaymentMethod(consoleMessage.message, context, true);
      //           },
      //           onReceivedHttpError: (controller, request, errorResponse) {
      //             printLog("HTTP Error: ${errorResponse.statusCode} ${errorResponse.reasonPhrase}");
      //           },
      //           onReceivedError: (controller, request, error) {
      //             printLog("Web Resource Error: ${error.description}");
      //           },
      //           onLoadError: (controller, url, code, message) {
      //             printLog("@@Error: $message");
      //           },
      //         ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////
// using webview package
////////////////////////////////////////////////////////////////////////
// import 'dart:convert';

// import 'package:flutter/cupertino.dart';

// import 'package:global365books/core/service/talus_pay/talus_pay_tokenizor.dart';
// import 'package:global365books/core/utils/print_log.dart';
// import 'package:global365books/widgets/Toast/delightful_toast_class.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AddCardSignUpWidget extends StatefulWidget {
//   const AddCardSignUpWidget({super.key});

//   @override
//   State<AddCardSignUpWidget> createState() => _AddCardSignUpWidgetState();
// }

// class _AddCardSignUpWidgetState extends State<AddCardSignUpWidget> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onHttpError: (HttpResponseError error) {},
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       )
//       ..addJavaScriptChannel("payment_add_submission", onMessageReceived: (message) {
//         try {
//           dynamic respMap = jsonDecode(message.message);
//           switch (respMap['status']) {
//             case 'success':
//               apiToAddCard(respMap["token"]);
//               break;
//             case 'error':
//               MyDelightFullToast.error(respMap["msg"], context);

//               break;
//             case 'validation':
//               MyDelightFullToast.error("Please enter valid card details", context);

//               break;
//           }
//         } on Exception catch (e) {
//           // TODO
//           gLogger(e);
//         }
//       })
//       ..setOnConsoleMessage((message) {
//         gLogger(message.message);
//       })
//       ..setOnJavaScriptAlertDialog((message) {
//         gLogger(message.message);
//         return Future.value();
//       })
//       ..loadHtmlString(PaymentProcessing.getHTMLString(btnText: "Proceed"));
//   }

//   bool isLoading = true;

//   apiToAddCard(String token) {
//     // call api to add card
//     APIsCallPost.submitRequest("/Users/ValidateAndCreateCustomer?Token=$token", {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(height: 150, width: 400, child: WebViewWidget(controller: controller));
//   }
// }
