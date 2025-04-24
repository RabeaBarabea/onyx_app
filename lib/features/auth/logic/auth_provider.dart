import 'package:flutter/material.dart';
import 'package:onyx_task_app/core/enums/state_enum.dart';
import 'package:onyx_task_app/features/auth/data/models/api_result.dart';
import 'package:onyx_task_app/features/auth/data/models/delivery_model.dart';
import 'package:onyx_task_app/features/auth/data/models/login_credentials.dart';
import 'package:onyx_task_app/features/auth/data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;
  DeliveryModel? deliveryModel;
  ApiResult? apiResult;

  StateEnum _state = StateEnum.initial;
  StateEnum get state => _state;

  AuthProvider({required this.authService});

  void changeState(StateEnum newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> login(LoginCredentials data) async {
    changeState(StateEnum.loading);

    apiResult = await authService.checkDdeliveryLogin(data);

    if (apiResult!.result.errNo == 0) {
      deliveryModel = DeliveryModel(
        name: apiResult!.data['DeliveryName'],
        deliveryNo: data.deliveryCode,
      );
      changeState(StateEnum.loaded);
      return true;
    }
    changeState(StateEnum.error);
    return false;
  }
}
