class ErrorMSG {
  bool success;
  String message;
  String code;
  ErrorMSG({required this.success,required this.message,required this.code});
  factory ErrorMSG.fromJson(Map<String, dynamic> json) =>
      ErrorMSG(
          success: json["success"],
          message: json["message"],
          code: json["code"]);
  Map<String, dynamic> toJson() =>{"success": success, "message": message, "code": code};
}