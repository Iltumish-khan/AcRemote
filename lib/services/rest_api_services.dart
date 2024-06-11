import 'package:demo_project/main_common.dart';
import 'package:demo_project/services/exports/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'exception_handling/api_exceptions.dart';

class ResponseData {
  dynamic data;
  int? statusCode;
  ResponseData({this.data, this.statusCode});
}

class RestApiServices {
  static var client = http.Client();
  // ignore: constant_identifier_names
  static const TIME_OUT_DURATION = Duration(seconds: 60);

  Future<dynamic> getRequest(dynamic requestBody, String endpoint,
      [dynamic header]) async {
    try {
      var finalURL = baseURL! + endpoint;
      var response = await client.get(
        Uri.parse(finalURL),
        headers: header,
      );
      AppHelper.showLog(finalURL.toString(), "GET REQUEST to");
      AppHelper.showLog(header.toString(), "Header in GET REQUEST");
      AppHelper.showLog(requestBody.toString(), "Body in GET REQUEST");
      AppHelper.showLog(response.statusCode.toString(),
          "Response Status Code from GET REQUEST");
      AppHelper.showLog(response.body.toString(), "Reponse from GET REQUEST");
      final responseData = ResponseData();
      responseData.statusCode = response.statusCode;
      responseData.data = _processResponse(response);
      return responseData;
    } on SocketException {
      throw NoInternetConnetionException(AppStrings.internetConnectionRequired);
    } on TimeoutException {
      throw ApiNotRespondingException(AppStrings.sessionExpired);
    }
  }

  Future<dynamic> postRequest(Object requestBody, String endpoint,
      [dynamic header]) async {
    try {
      var finalURL = baseURL! + endpoint;
      var response = await client.post(Uri.parse(finalURL),
          headers: header, body: requestBody);
      AppHelper.showLog(finalURL, "POST REQUEST to");
      AppHelper.showLog(header.toString(), "Header in POST REQUEST");
      AppHelper.showLog(requestBody.toString(), "Body in POST REQUEST");
      AppHelper.showLog(response.statusCode.toString(),
          "Response Status Code from POST REQUEST");
      AppHelper.showLog(response.body.toString(), "Reponse from POST REQUEST");
      final responseData = ResponseData();
      responseData.statusCode = response.statusCode;
      responseData.data = _processResponse(response);
      return responseData;
    } on SocketException {
      throw NoInternetConnetionException(AppStrings.internetConnectionRequired);
    } on TimeoutException {
      ApiNotRespondingException(AppStrings.sessionExpired);
    }
  }

  Future<dynamic> putRequest(dynamic requestBody, String endpoint,
      [dynamic header]) async {
    try {
      var finalURL = baseURL! + endpoint;
      var response = await client.put(
        Uri.parse(finalURL),
        body: requestBody,
        headers: header,
      );
      AppHelper.showLog(finalURL, "PUT REQUEST to");
      AppHelper.showLog(header.toString(), "Header in PUT REQUEST");
      AppHelper.showLog(baseURL! + endpoint, "PUT REQUEST to");
      AppHelper.showLog(requestBody.toString(), "Body in PUT REQUEST");
      AppHelper.showLog(response.body.toString(), "Response from PUT REQUEST");
      final responseData = ResponseData();
      AppHelper.showLog(response.statusCode.toString(),
          "Response Status Code from PUT REQUEST");
      responseData.statusCode = response.statusCode;
      responseData.data = _processResponse(response);
      return responseData;
    } on SocketException {
      throw NoInternetConnetionException(AppStrings.internetConnectionRequired);
    } on TimeoutException {
      ApiNotRespondingException(AppStrings.sessionExpired);
    }
  }

  Future<dynamic> deleteRequest(dynamic requestBody, String endpoint,
      [dynamic header]) async {
    try {
      var finalURL = baseURL! + endpoint;
      var response = await client.delete(
        Uri.parse(finalURL),
        body: requestBody,
        headers: header,
      );
      final responseData = ResponseData();
      responseData.statusCode = response.statusCode;
      responseData.data = _processResponse(response);
      return responseData;
    } on SocketException {
      throw NoInternetConnetionException(AppStrings.internetConnectionRequired);
    } on TimeoutException {
      ApiNotRespondingException(AppStrings.sessionExpired);
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
      case 204:
      case 205:
      case 206:
      case 207:
      case 208:
      case 209:
      case 210:
        return utf8.decode(response.bodyBytes);
      case 400:
        throw FetchDataException(utf8.decode(response.bodyBytes));
      case 401:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes));
      case 403:
        throw AccountDisabledException(utf8.decode(response.bodyBytes));
      case 404:
        throw ResourceNotFoundException(utf8.decode(response.bodyBytes));
      case 422:
        throw UserInputError(utf8.decode(response.bodyBytes));
      case 429:
        throw TooManyAttemptsException("Too Many Attempts!");
      case 500:
        throw InternalServerException(utf8.decode(response.bodyBytes));
      case 502:
        throw NoInternetConnetionException(utf8.decode(response.bodyBytes));
      default:
        throw FetchDataException(utf8.decode(response.bodyBytes));
    }
  }
}
