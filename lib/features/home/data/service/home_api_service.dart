import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:onyx_task_app/core/constants/api_constants.dart';
import 'package:onyx_task_app/features/auth/data/models/api_result.dart';
import 'package:onyx_task_app/features/home/data/models/delivery_request.dart';

class HomeApi {
  final Dio dio;
  HomeApi(this.dio);

  Future<ApiResult> getDeliveryBillsItems(
    DeliveryRequest delivreyRequest,
  ) async {
    final result = await dio.post(
      ApiConstants.getDeliveryBillsItems,
      data: jsonEncode({"Value": delivreyRequest.toJson()}),
    );
    return ApiResult.fromMap(result.data);
  }

  Future<ApiResult> getDeliveryStatusTypes(String langCode) async {
    final result = await dio.post(
      ApiConstants.getDeliveryBillsItems,
      data: jsonEncode({
        "Value": {"P_LANG_NO": langCode},
      }),
    );
    return ApiResult.fromMap(result.data);
  }
}
