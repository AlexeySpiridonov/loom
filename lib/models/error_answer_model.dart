class ErrorAnswerModel {
  int errCode = 0;
  String errMsg = "";
  ErrorAnswerModel({
    required this.errCode,
    required this.errMsg,
  });

  ErrorAnswerModel.fromJson(Map<String, dynamic> json)
      : errCode = json['errCode'],
        errMsg = json['errMsg'];
}
