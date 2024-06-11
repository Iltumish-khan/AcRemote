import 'dart:convert';

//422 Error Handler model
UserInputTypeErrorModel userInputTypeErrorModelFromJson(String str) =>
    UserInputTypeErrorModel.fromJson(json.decode(str));

String userInputTypeErrorModelToJson(UserInputTypeErrorModel data) =>
    json.encode(data.toJson());

class UserInputTypeErrorModel {
  UserInputTypeErrorModel({
    this.message,
    this.errors,
  });

  String? message;
  Map? errors;

  factory UserInputTypeErrorModel.fromJson(Map<String, dynamic> json) =>
      UserInputTypeErrorModel(
        message: json["message"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors,
      };
}

CommonErrorResponse commonErrorResponseFromJson(String /*!*/ str) =>
    CommonErrorResponse.fromJson(json.decode(str));

String commonErrorResponseToJson(CommonErrorResponse data) =>
    json.encode(data.toJson());

class CommonErrorResponse {
  CommonErrorResponse({
    this.message,
  });

  String? message;

  factory CommonErrorResponse.fromJson(Map<String, dynamic> json) =>
      CommonErrorResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
