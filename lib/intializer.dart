import 'package:get/get.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/api_constant.dart';

class Global365Widgets {
  static init(String baseUrl, G365Module module) {
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }
    ApiConstant.baseUrl = baseUrl;
    apiLink = baseUrl;
    g365Module = module;
  }
}

enum G365Module { accounting, payroll, merchant }
