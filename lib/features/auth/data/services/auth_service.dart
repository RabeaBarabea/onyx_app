import "dart:convert";

import "package:dio/dio.dart";
import "package:onyx_task_app/core/constants/api_constants.dart";
import "package:onyx_task_app/features/auth/data/models/api_result.dart";
import "package:onyx_task_app/features/auth/data/models/login_credentials.dart";

class AuthService {
  final Dio dio;
  AuthService({required this.dio});

  Future<ApiResult> checkDdeliveryLogin(LoginCredentials data) async {
    try {
      final result = await dio.post(
        ApiConstants.checkDeliveryLogin,
        data: jsonEncode({"Value": data.toMap()}),
      );
      final apiResult = ApiResult.fromMap(result.data);
      return apiResult;
    } catch (e) {
      return ApiResult(
        data: {},
        result: Result(errNo: -111, errMsg: e.toString()),
      );
    }
  }
}
