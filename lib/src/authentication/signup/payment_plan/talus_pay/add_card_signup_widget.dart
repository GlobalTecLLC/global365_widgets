/////////////////////////////////////////////////////////////////////////
// using inappwebview package
////////////////////////////////////////////////////////////////////////

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/payment_method_service.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/talus_pay_tokenizor.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/web_widget.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class AddCardSignUpWidget extends StatefulWidget {
  const AddCardSignUpWidget({super.key});

  @override
  State<AddCardSignUpWidget> createState() => _AddCardSignUpWidgetState();
}

class _AddCardSignUpWidgetState extends State<AddCardSignUpWidget> {
  late InAppWebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 400,
      child:
          // Container());
          (kIsWeb)
          ? WebViewWebPayment(isSignUp: true)
          : InAppWebView(
              initialData: InAppWebViewInitialData(data: PaymentProcessing.getHTMLString(btnText: "Proceed")),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                allowUniversalAccessFromFileURLs: true,
                allowFileAccessFromFileURLs: true,
              ),
              onWebViewCreated: (controller) {
                gLogger("WebView created123");
                controller = controller;
              },
              onLoadStart: (controller, url) {
                gLogger("on load start");
              },
              onLoadStop: (controller, url) async {
                gLogger("on load stop");
              },
              onNavigationResponse: (controller, navigationResponse) async {
                gLogger("Navigation Response: ${navigationResponse.response?.statusCode}");
                return NavigationResponseAction.CANCEL;
              },
              onConsoleMessage: (controller, consoleMessage) {
                PaymentMethodService.onSubmissionOfPaymentMethod(consoleMessage.message, context, true);
              },
              onReceivedHttpError: (controller, request, errorResponse) {
                gLogger("HTTP Error: ${errorResponse.statusCode} ${errorResponse.reasonPhrase}");
              },
              onReceivedError: (controller, request, error) {
                gLogger("Web Resource Error: ${error.description}");
              },
              onLoadError: (controller, url, code, message) {
                gLogger("@@Error: $message");
              },
            ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////
// using webview package
////////////////////////////////////////////////////////////////////////
// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:global365books/Services/post_requests.dart';
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
