import 'package:flutter/material.dart';
import 'package:onyx_task_app/core/enums/state_enum.dart';
import 'package:onyx_task_app/features/home/data/models/bill_model.dart';
import 'package:onyx_task_app/features/home/data/models/delivery_request.dart';
import 'package:onyx_task_app/features/home/data/models/delivery_status_types.dart';
import 'package:onyx_task_app/features/home/data/service/home_api_service.dart';
import 'package:onyx_task_app/features/home/data/service/home_db_service.dart';

class HomeProvider with ChangeNotifier {
  final HomeApi api;
  final HomeDb db;

  List<BillModel> _bills = [];
  List<BillModel> get bills => _bills;

  List<DeliveryStatusType> _statusTypes = [];
  List<DeliveryStatusType> get statusTypes => _statusTypes;

  StateEnum _state = StateEnum.initial;
  StateEnum get state => _state;

  void changeState(StateEnum newState) {
    _state = newState;
    notifyListeners();
  }

  HomeProvider(this.api, this.db);

  Future<void> getData(DeliveryRequest deliveryRequest, String langCode) async {
    await Future.wait([
      getDeliveryBillsItems(deliveryRequest),
      getStatusTypes(langCode),
      getLocalBills(),
    ]);
  }

  Future<void> getLocalBills() async {
    _bills = await db.fetchBills();
    notifyListeners();
  }

  Future<void> getDeliveryBillsItems(DeliveryRequest deliveryRequest) async {
    changeState(StateEnum.loading);
    final apiResult = await api.getDeliveryBillsItems(deliveryRequest);
    if (apiResult.result.errNo == 0) {
      final items = (apiResult.data['DeliveryBills'] as List);
      final billsFromApi = List.generate(
        items.length,
        (i) => BillModel.fromMap(items[i]),
      );
      await db.insertBills(billsFromApi);
      await getLocalBills();
      changeState(StateEnum.loaded);
    } else {
      changeState(StateEnum.error);
    }
  }

  Future<void> getStatusTypes(String langCode) async {
    final apiResult = await api.getDeliveryStatusTypes(langCode);
    if (apiResult.result.errNo == 0) {
      final items = (apiResult.data as List);
      _statusTypes = List.generate(
        items.length,
        (i) => DeliveryStatusType.fromJson(items[i]),
      );
    }
    notifyListeners();
  }

  Future<void> filterByStatus(String status) async {
    _bills = await db.fetchBills(statusFilter: status);
    notifyListeners();
  }
}
