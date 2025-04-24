class LoginCredentials {
  final String langCode;
  final String deliveryCode;
  final String password;
  LoginCredentials({
    required this.langCode,
    required this.deliveryCode,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'P_LANG_NO': langCode,
      'P_DLVRY_NO': deliveryCode,
      'P_PSSWRD': password,
    };
  }
}
