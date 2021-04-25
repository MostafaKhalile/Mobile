import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class Validator {
  String error;
  // String alert = "\u26A0";

  validateEmail(BuildContext context, data) {
    if (data == null || data == '') {
      error = AppLocalizations.of(context).translate("please_enter_email");
      return error;
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(data)) {
      error =
          AppLocalizations.of(context).translate("please_enter_valid_email");
      return error;
    }
    error = null;
    return error;
  }

  String validateUsername(BuildContext context, data) {
    if (data == null || data == '') {
      error = "لا يمكن ترك هذه الخانة فارغة";
      return error;
    }
    if (!RegExp(r"^[a-zA-Z0-9\u0621-\u064A]+$").hasMatch(data)) {
      error = " برجاء ادخال اسم يحتوي على حروف و ارقام فقط ";
      return error;
    }
    error = null;
    return error;
  }

  String phoneNumber(BuildContext context, data) {
    if (data == null || data == '') {
      error = "لا يمكن ترك هذه الخانة فارغة";
      return error;
    }
    if (!RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$")
        .hasMatch("966" + data)) {
      error = " برجاء ادخال رقم سعودي";
      return error;
    }
    error = null;
    return error;
  }

  String validatePassword(BuildContext context, data) {
    if (data == null || data == '') {
      error = " برجاء ادخال كلمة المرور  صحيحة";
      return error;
    }
    if (data.toString().length < 8 || data.toString().length > 12) {
      error = "كلمة المرور يجب ان نكون  من 8 الي 12 احرف";
      return error;
    }
    error = null;

    return error;
  }

  String commericalRegister(BuildContext context, data) {
    if (data == null || data == '') {
      error = "لا يمكن ترك هذه الخانة فارغة";
      return error;
    }
    if (!RegExp(r"^[a-zA-Z0-9\u0621-\u064A]+$").hasMatch(data)) {
      error = " برجاء ادخال اسم يحتوي على حروف و ارقام فقط ";
      return error;
    }
    if (data.toString().length > 10) {
      error = "برجاء ادخال سجل تجاري صحيح";
      return error;
    }
    error = 'noError';
    return error;
  }
}
