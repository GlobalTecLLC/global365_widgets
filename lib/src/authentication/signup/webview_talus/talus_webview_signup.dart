import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:go_router/go_router.dart';

class TalusWebviewSignup extends StatelessWidget {
  TalusWebviewSignup({super.key, required this.url});
  final String url;
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
          onLoadStart: (controller, url) {
            // Listen to URL changes here
            isLoading.value = true;
            debugPrint('Page started loading: $url');
          },
          onLoadStop: (controller, url) async {
            // You can also listen here when page finishes loading
            isLoading.value = false;

            debugPrint('Page finished loading: $url');
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            // This is called when the URL changes
            debugPrint('URL changed: $url');
            if (url.toString().contains('merchantSuccess')) {
              // Handle success case, e.g., navigate to another page
              GNav.goNav(context, GRouteConfig.merchantSuccess);
            } else if (url.toString().contains('error')) {
              // Handle error case
              debugPrint('Signup failed, showing error...');
              // Show an error message or handle accordingly
            }
          },
          onNavigationResponse: (controller, navigationResponse) {
            // Handle navigation responses

            debugPrint('Navigation response: ${navigationResponse.response}');
            return Future.value(NavigationResponseAction.ALLOW);
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Obx(
          () => isLoading.value
              ? Positioned.fill(top: 0, left: 0, child: Center(child: CircularProgressIndicator()))
              : Container(),
        ),
      ],
    );
  }
}
