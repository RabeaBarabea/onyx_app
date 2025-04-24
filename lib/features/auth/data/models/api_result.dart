class ApiResult {
  final Map data;
  final Result result;
  ApiResult({required this.data, required this.result});

  factory ApiResult.fromMap(Map<String, dynamic> apiResult) {
    return ApiResult(
      data: apiResult["Data"],
      result: Result.fromMap(apiResult["Result"]),
    );
  }
}

class Result {
  final int errNo;
  final String errMsg;

  Result({required this.errNo, required this.errMsg});

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(errNo: map['ErrNo'], errMsg: map['ErrMsg']);
  }
}
