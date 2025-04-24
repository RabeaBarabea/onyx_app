import 'package:flutter/material.dart';
import 'package:onyx_task_app/features/home/data/models/bill_model.dart';

class BillCard extends StatelessWidget {
  final BillModel bill;

  const BillCard({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#${bill.billNo}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildColumn(
                        "Status",
                        bill.dlvryStatusFlg,
                        const Color(0xFF00C853),
                      ), // Green
                      _verticalDivider(),
                      _buildColumn(
                        "Total price",
                        (bill.billAmt + bill.dlvryAmt + bill.taxAmt).toString(),
                        const Color(0xFF004D61),
                      ), // Dark blue
                      _verticalDivider(),
                      _buildColumn(
                        "Date",
                        bill.billDate,
                        const Color(0xFF004D61),
                      ), // Dark blue
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            width: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF00C853), // Bright green
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "Order Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(height: 30, width: 1, color: Colors.grey[300]);
  }
}
