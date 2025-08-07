import 'package:get/get.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global365Widgets {
  static late Function(dynamic) loginCallBack;
  static init(String baseUrl, G365Module module, SharedPreferences prefsTemp, Function(dynamic) loginCallBackFunction) {
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }
    loginCallBack = loginCallBackFunction;
    prefs = prefsTemp;
    ApiConstant.baseUrl = baseUrl;
    apiLink = baseUrl;
    g365Module = module;
  }
}

enum G365Module { accounting, payroll, merchant , employeePortal}
