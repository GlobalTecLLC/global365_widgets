import 'package:flutter/foundation.dart';

gLogger(dynamic data) {
  if (kDebugMode) {
    print(data.toString());
  }
}
  