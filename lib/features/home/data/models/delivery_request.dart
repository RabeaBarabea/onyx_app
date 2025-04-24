class DeliveryRequest {
  final String pDlvryNo;
  final String pLangNo;
  final String pBillSrl;
  final String pPrcssdFlg;

  DeliveryRequest({
    required this.pDlvryNo,
    required this.pLangNo,
    required this.pBillSrl,
    required this.pPrcssdFlg,
  });

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DeliveryRequest(
      pDlvryNo: json['P_DLVRY_NO'] ?? '',
      pLangNo: json['P_LANG_NO'] ?? '',
      pBillSrl: json['P_BILL_SRL'] ?? '',
      pPrcssdFlg: json['P_PRCSSD_FLG'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'P_DLVRY_NO': pDlvryNo,
      'P_LANG_NO': pLangNo,
      'P_BILL_SRL': pBillSrl,
      'P_PRCSSD_FLG': pPrcssdFlg,
    };
  }
}
