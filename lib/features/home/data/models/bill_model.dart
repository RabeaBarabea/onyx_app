class BillModel {
  final String billType;
  final String billNo;
  final String billSrl;
  final String billDate;
  final String billTime;
  final double billAmt;
  final double taxAmt;
  final double dlvryAmt;
  final String mobileNo;
  final String customerName;
  final String dlvryStatusFlg;

  BillModel({
    required this.billType,
    required this.billNo,
    required this.billSrl,
    required this.billDate,
    required this.billTime,
    required this.billAmt,
    required this.taxAmt,
    required this.dlvryAmt,
    required this.mobileNo,
    required this.customerName,
    required this.dlvryStatusFlg,
  });

  factory BillModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return BillModel(
      billType: map['BILL_TYPE'] ?? "",
      billNo: map['BILL_NO'] ?? "",
      billSrl: map['BILL_SRL'] ?? "",
      billDate: map['BILL_DATE'] ?? "",
      billTime: map['BILL_TIME'] ?? "",
      billAmt: double.parse(map['BILL_AMT'] ?? "0"),
      taxAmt: double.parse(map['TAX_AMT'] ?? "0"),
      dlvryAmt: double.parse(map['DLVRY_AMT'] ?? "0"),
      mobileNo: map['MOBILE_NO'] ?? "",
      customerName: map['CSTMR_NM'] ?? "",
      dlvryStatusFlg: map['DLVRY_STATUS_FLG'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bill_type': billType,
      'bill_no': billNo,
      'bill_srl': billSrl,
      'bill_date': billDate,
      'bill_time': billTime,
      'bill_amt': billAmt,
      'tax_amt': taxAmt,
      'dlvry_amt': dlvryAmt,
      'mobile_no': mobileNo,
      'customer_name': customerName,
      'dlvry_status_flg': dlvryStatusFlg,
    };
  }
}
