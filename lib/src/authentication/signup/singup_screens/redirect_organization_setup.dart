import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/utils/export_utils.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class RedirectOrganizationSetup extends StatefulWidget {
  const RedirectOrganizationSetup({
    super.key,
    this.organizationId,
    this.organizationName,
    required this.accessToken,
    this.phoneNumber = "",
  });

  final String? organizationId;
  final String? organizationName;
  final String accessToken;
  final String phoneNumber;

  @override
  State<RedirectOrganizationSetup> createState() => _RedirectOrganizationSetupState();
}

class _RedirectOrganizationSetupState extends State<RedirectOrganizationSetup> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the redirect method after the first frame is rendered
      redirect();
    });
    super.initState();
  }

  redirect() {
    // This method should handle the redirection logic based on the organizationId and organizationName
    // For example, you might want to navigate to a specific setup screen or perform some API calls.
    if (widget.organizationId != null && widget.organizationName != null && widget.accessToken.isNotEmpty) {
      accessToken = widget.accessToken; // Set the access token globally
      SetUpController controller = Get.put(SetUpController());
      controller.businessName.text = widget.organizationName!;
      controller.existingCompany = widget.organizationId!; // Set the location ID
      controller.phoneNumber.text = widget.phoneNumber; // Set the phone number
      controller.isExistingCompany = true; // Indicate that this is an existing company
      // Assuming organizationId is the location ID
      gLogger("Access Token: $accessToken");
      // Navigate to the setup screen with the organization details
      GNav.goNav(context, GRouteConfig.setUpScreenRoute);
    } else {
      // Handle the case where organization details are not provided
      GToast.error("Organization details are missing. Please try again.", context);
      GNav.goNav(context, GRouteConfig.loginUsaPageRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
