class DeliveryStatusType {
  final String typeNo;
  final String typeName;

  DeliveryStatusType({required this.typeNo, required this.typeName});

  factory DeliveryStatusType.fromJson(Map<String, dynamic> json) {
    return DeliveryStatusType(typeNo: json['TYP_NO'], typeName: json['TYP_NM']);
  }

  Map<String, dynamic> toMap() {
    return {'type_no': typeNo, 'type_name': typeName};
  }
}
