import 'package:dio/dio.dart';
import 'package:global365_widgets/src/utils/api_constant.dart';

import 'api_logging.dart';

class DioClient {
  final BaseOptions baseOptions = BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    connectTimeout: Duration(seconds: 100),
    receiveTimeout: Duration(seconds: 100),
  );

  late Dio dio;

  DioClient() {
    dio = Dio(baseOptions)..interceptors.add(ApiLogging());
  }
}
