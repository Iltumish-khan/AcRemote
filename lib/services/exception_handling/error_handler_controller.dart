import 'package:demo_project/services/exception_handling/api_exception_model.dart';
import 'package:demo_project/utils/app_colors.dart';
import 'package:demo_project/utils/app_helper.dart';
import 'package:demo_project/utils/app_strings.dart';

import '../../components/progress_loader.dart';
import 'api_exceptions.dart';

class ErrorHandler {
  void handleError(error) {
    hideLoading();
    AppHelper.showLog(error.toString(), "Exception from API");
    if (error is FetchDataException) {
      if (error.message!.contains("message")) {
        CommonErrorResponse commonErrorResponse =
            commonErrorResponseFromJson(error.message!);
        AppHelper.showToastMessage(
            commonErrorResponse.message.toString(), dangerColor);
      } else {
        AppHelper.showToastMessage(error.message.toString(), dangerColor);
      }
      return;
    }
    if (error is InternalServerException) {
      if (error.message!.contains("message")) {
        CommonErrorResponse commonErrorResponse =
            commonErrorResponseFromJson(error.message!);
        AppHelper.showToastMessage(
            commonErrorResponse.message.toString(), dangerColor);
      } else {
        AppHelper.showToastMessage(
            error.message ?? "Something Went Wrong", dangerColor);
      }
      return;
    }
    if (error is ApiNotRespondingException) {
      if (error.message!.contains("message")) {
        CommonErrorResponse commonErrorResponse =
            commonErrorResponseFromJson(error.message!);
        AppHelper.showToastMessage(
            commonErrorResponse.message.toString(), dangerColor);
      } else {
        AppHelper.showToastMessage(error.message.toString(), dangerColor);
      }
      return;
    }
    if (error is UnAuthorizedException) {
      CommonErrorResponse commonErrorResponse =
          commonErrorResponseFromJson(error.message!);
      AppHelper.showToastMessage(
          commonErrorResponse.message ?? "Unauthenticated", dangerColor);
      AppHelper.clearAllDataSetRouteToLogin();
      return;
    }
    if (error is AccountDisabledException) {
      CommonErrorResponse commonErrorResponse =
          commonErrorResponseFromJson(error.message!);
      AppHelper.showToastMessage(
          commonErrorResponse.message.toString(), dangerColor);
      AppHelper.clearAllDataSetRouteToLogin();
      return;
    }
    if (error is UserInputError) {
      UserInputTypeErrorModel userInputTypeErrorModel =
          userInputTypeErrorModelFromJson(error.message!);
      List<dynamic> value =
          userInputTypeErrorModel.errors!.values.first as List<dynamic>;
      AppHelper.showToastMessage(value[0].toString(), dangerColor);
      return;
    }
    if (error is ResourceNotFoundException) {
      if (error.message!.contains("message")) {
        CommonErrorResponse commonErrorResponse =
            commonErrorResponseFromJson(error.message!);
        AppHelper.showToastMessage(
            commonErrorResponse.message.toString(), dangerColor);
      } else {}
      return;
    }
    if (error is TooManyAttemptsException) {
      AppHelper.showToastMessage(
          error.message ?? "Something went wrong.", dangerColor);
      // showTooManyAttempts(NavigationService.navigatorKey.currentState?.overlay?.context);
      return;
    }
    if (error is NoInternetConnetionException) {
      AppHelper.showToastMessage(error.message!, dangerColor);
      return;
    }

    CommonErrorResponse commonErrorResponse =
        commonErrorResponseFromJson(error.toString());
    AppHelper.showToastMessage(
        commonErrorResponse.message ?? "Something went wrong.", dangerColor);
    return;
  }

  showLoading() {
    // ProgressLoader.showLoadingDialog();
  }

  showTooManyAttempts(context) {
    ProgressLoader.showTooManyAttemptsDialog(
        "Alert", AppStrings.tooManyAttemptsString, context);
  }

  hideLoading() {
    // ProgressLoader.hideLoadingDialog();
  }
}
