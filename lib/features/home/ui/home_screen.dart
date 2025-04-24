import 'package:flutter/material.dart';
import 'package:onyx_task_app/core/enums/state_enum.dart';
import 'package:onyx_task_app/features/auth/data/models/delivery_model.dart';
import 'package:onyx_task_app/features/auth/logic/auth_provider.dart';
import 'package:onyx_task_app/features/home/data/models/bill_model.dart';
import 'package:onyx_task_app/features/home/data/models/delivery_request.dart';
import 'package:onyx_task_app/features/home/logic/home_provider.dart';
import 'package:onyx_task_app/features/home/ui/widgets/bill_card.dart';
import 'package:onyx_task_app/features/home/ui/widgets/taps_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DeliveryModel _deliveryModel;
  final String langCode = "2";

  @override
  void initState() {
    _deliveryModel = context.read<AuthProvider>().deliveryModel!;
    //getData();
    super.initState();
  }

  void getData() {
    context.read<HomeProvider>().getData(
      DeliveryRequest(
        pDlvryNo: _deliveryModel.deliveryNo,
        pLangNo: langCode,
        pBillSrl: "",
        pPrcssdFlg: "",
      ),
      langCode,
    );
  }

  String selectedTab = "New";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            TapsWidget(),
            const SizedBox(height: 16),
            Expanded(child: _buildOrdersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFD32F2F), // red header background
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              _deliveryModel.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Image.asset('assets/deliveryman.png'), // replace with your asset
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        final bills = provider.bills;
        return provider.state == StateEnum.loading
            ? Center(child: CircularProgressIndicator())
            : bills.isEmpty
            ? Text("No data")
            : ListView.builder(
              itemCount: bills.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final bill = bills[index];
                return BillCard(bill: bill);
              },
            );
      },
    );
  }

  Widget _buildOrderCard(BillModel bill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bill.billNo),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.billNo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Column(
                      children: [
                        const Text("Status: ", style: TextStyle(fontSize: 12)),
                        Text(
                          bill.dlvryStatusFlg,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(indent: 0),
                    Column(
                      children: [
                        const Text(
                          "Total price: ",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          (bill.billAmt + bill.dlvryAmt + bill.taxAmt)
                              .toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Column(
                      children: [
                        const Text("Date: ", style: TextStyle(fontSize: 12)),
                        Text(
                          bill.billDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Order\nDetails",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
