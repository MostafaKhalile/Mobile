import 'package:flutter/material.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class Validator {
  String error;
  // String alert = "\u26A0";

  String validateEmail(BuildContext context, String data) {
    if (data == null || data == '') {
      return error =
          AppLocalizations.of(context).translate("please_enter_email");
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(data)) {
      return error =
          AppLocalizations.of(context).translate("please_enter_valid_email");
    }

    return error = null;
  }

  String validateEmailMobile(BuildContext context, String data) {
    if (data == null || data == '') {
      return error = AppLocalizations.of(context)
          .translate("please_enter_email_or_mobile");
    }
    if (!RegExp(
            r"([a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)|(^01[0125][0-9]{8}$)")
        .hasMatch(data)) {
      return error = AppLocalizations.of(context)
          .translate("please_enter_valid_email_or_mobile");
    }

    return error = null;
  }

  String validateUsername(BuildContext context, String data) {
    if (data == null || data == '') {
      return error = "لا يمكن ترك هذه الخانة فارغة";
    }
    if (!RegExp(r"^[a-zA-Z0-9\u0621-\u064A]+$").hasMatch(data)) {
      return error = " برجاء ادخال اسم يحتوي على حروف و ارقام فقط ";
    }
  
    return   error = null;
  }

  String phoneNumber(BuildContext context, String data) {
    if (data == null || data == '') {
      return error =
          AppLocalizations.of(context).translate("this_field_is_required");
    }
    if (!RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$")
        .hasMatch("966$data")) {
      return error = " برجاء ادخال رقم سعودي";
    }

    return error = null;
  }

  String validatePassword(BuildContext context, String data) {
    if (data == null || data == '') {
      return error =
          AppLocalizations.of(context).translate("please_enter_password");
    }
    if (data.toString().length < 6 || data.toString().length > 12) {
      return error =
          AppLocalizations.of(context).translate("password_length_error");
    }
   

    return error = null;
  }

  String commericalRegister(BuildContext context, String data) {
    if (data == null || data == '') {
      return error = "لا يمكن ترك هذه الخانة فارغة";
      
    }
    if (!RegExp(r"^[a-zA-Z0-9\u0621-\u064A]+$").hasMatch(data)) {
      return error = " برجاء ادخال اسم يحتوي على حروف و ارقام فقط ";
    }
    if (data.toString().length > 10) {
      return error = "برجاء ادخال سجل تجاري صحيح";
    }

    return error = 'noError';
  }
}
