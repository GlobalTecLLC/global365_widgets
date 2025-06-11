import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/payment_method_service.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/talus_pay_tokenizor.dart';
import 'package:global365_widgets/src/authentication/signup/payment_plan/talus_pay/web_widget.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class AddCardWidget extends StatefulWidget {
  AddCardWidget({super.key});
  @override
  State<AddCardWidget> createState() => _AddCardWidgetState();
}

class _AddCardWidgetState extends State<AddCardWidget> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 400,
      child:
          // Container());
          (kIsWeb)
          ? WebViewWebPayment()
          : InAppWebView(
              initialData: InAppWebViewInitialData(data: PaymentProcessing.getHTMLString()),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                allowUniversalAccessFromFileURLs: true,
                allowFileAccessFromFileURLs: true,
                useOnNavigationResponse: true,
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
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
                PaymentMethodService.onSubmissionOfPaymentMethod(consoleMessage.message, context, false);
              },
              onReceivedHttpError: (controller, request, errorResponse) {
                gLogger("HTTP Error: ${errorResponse.statusCode} ${errorResponse.reasonPhrase}");
              },
              onReceivedError: (controller, request, error) {
                gLogger("Web Resource Error: ${error.description}");
              },
            ),
    );
  }
}
