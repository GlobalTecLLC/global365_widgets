import 'package:flutter/material.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/payment_method_service.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/talus_pay_tokenizor.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebViewWebPayment extends StatelessWidget {
  WebViewWebPayment({super.key, this.isSignUp = false});
  late WebViewXController webviewController;
  bool isSignUp;
  @override
  Widget build(BuildContext context) {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: PaymentProcessing.getHTMLString(
        isWeb: true,
        btnText: isSignUp ? "Proceed" : "Add Payment Method",
      ),
      initialSourceType: SourceType.html,
      height: 150,
      width: 400,
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) => debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) => debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }"),
        EmbeddedJsContent(
          webJs: "function paymentAddSubmissionCallBack(msg) { PaymentAddSubmission(msg) }",
          mobileJs: "function paymentAddSubmissionCallBack(msg) { PaymentAddSubmission.postMessage(msg) }",
        ),
      },
      dartCallBacks: {
        DartCallback(
          name: 'PaymentAddSubmission',
          callBack: (msg) => PaymentMethodService.onSubmissionOfPaymentMethod(msg, context, isSignUp),
        ),
      },
      webSpecificParams: const WebSpecificParams(printDebugInfo: true),
    );
  }
}
