import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/api_services/response_model/resonse_model.dart';

import 'package:global365_widgets/src/utils/api_constant.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/progressDialog.dart';

class PaymentMethodService {
  static onSubmissionOfPaymentMethod(String message, BuildContext context, bool isSignUp) {
    if (message.contains("payment_add_submission")) {
      try {
        String jsonPart = "";
        if (kIsWeb) {
          jsonPart = message.replaceAll("payment_add_submission: ", "").trim();
        } else {
          jsonPart = message.replaceAll("payment_add_submission", "").trim();
        }
        gLogger("Extracted JSON part=>  $jsonPart");

        dynamic decodedJson = jsonDecode(jsonPart);
        gLogger("Decoded JSON: $decodedJson");
        gLogger("Decoded JSON: ${decodedJson.runtimeType}");
        dynamic firstDecode = jsonDecode(jsonPart);
        if (firstDecode is String) {
          gLogger("First decode returned a String. Decoding again...");
          decodedJson = jsonDecode(firstDecode);
        }

        if (decodedJson is Map<String, dynamic>) {
          Map<String, dynamic> respMap = decodedJson;

          // Check for the status key
          if (respMap.containsKey('status')) {
            String status = respMap['status'];
            gLogger("Status key exists: $status");

            // Handle different status cases
            switch (status) {
              case 'success':
                if (respMap.containsKey("token")) {
                  String token = respMap["token"];
                  if (isSignUp) {
                    validateAndCreateCustomer(token, context);
                  } else {
                    apiToAddCard(token, context);
                  }
                  gLogger("Success: Card added with token: $token");
                } else {
                  gLogger("Error: 'token' key missing in 'success' response.");
                }
                break;

              case 'error':
                if (respMap.containsKey("msg")) {
                  String errorMsg = respMap["msg"];
                  GToast.error(errorMsg, context);
                  gLogger("Error: $errorMsg");
                } else {
                  gLogger("Error: 'msg' key missing in 'error' response.");
                }
                break;

              case 'validation':
                if (respMap.containsKey("invalid")) {
                  List invalidFields = respMap["invalid"];
                  GToast.error("Please enter valid card details", context);
                  gLogger("Validation Error: Invalid fields - $invalidFields");
                } else {
                  gLogger("Validation Error: 'invalid' key missing in response.");
                }
                break;

              default:
                gLogger("Unknown status: $status");
                break;
            }
          } else {
            gLogger("Error: 'status' key missing in response.");
          }
        } else {
          gLogger("Error: Decoded JSON is not a Map. Received: ${decodedJson.runtimeType}");
        }
      } catch (e, stackTrace) {
        // Log the parsing error and stack trace
        gLogger("Parsing Error: $e");
        gLogger("Stack Trace: $stackTrace");
      }
    }
  }

  static void apiToAddCard(String token, BuildContext context) async {
    ResponseModel resp = await APIsCallPost.submitRequest(
      "Companies/AddPaymentMethod?Token=$token&CompanyId=$companyId",
      {},
    );


    if (resp.statusCode == 200 || resp.statusCode == 201) {
      Navigator.of(context).pop();
      GToast.succss("Payment method added successfully", context);
      // PlanAndBillingController.to.getPaymentMethodsList(context);
    }
  }

  static void validateAndCreateCustomer(String token, BuildContext context) async {
    // call api to add card
    gLogger("inside Create user api call");
    ResponseModel response = await APIsCallPost.submitRequest("Users/ValidateAndCreateCustomer?Token=$token", {});
    gLogger("Response from ValidateAndCreateCustomer: ${response.data}");
    gLogger("Response status code: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // AutoRouter.of(context).push(const SetUpScreenRoute());
      GProgressDialog(context).hide();
      GNav.goNav(context, GRouteConfig.setUpScreenRoute); 
    
    }
  }
}
