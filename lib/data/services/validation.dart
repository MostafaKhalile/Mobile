class Validation {
  String error;
  String validateEmail(data) {
    if (data == null || data == '') {
      error = "برجاء ادخال البريد الإلكتروني";
      return error;
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(data)) {
      error = " برجاء ادخال بريد إلكتروني صحيح";
      return error;
    }
    error = 'noError';
    return error;
  }

  String validateUsername(data) {
    if (data == null || data == '') {
      error = "لا يمكن ترك هذه الخانة فارغة";
      return error;
    }
    if (!RegExp(r"^[a-zA-Z0-9\u0621-\u064A]+$").hasMatch(data)) {
      error = " برجاء ادخال اسم يحتوي على حروف و ارقام فقط ";
      return error;
    }
    error = 'noError';
    return error;
  }

  String phoneNumber(data) {
    if (data == null || data == '') {
      error = "لا يمكن ترك هذه الخانة فارغة";
      return error;
    }
    if (!RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$")
        .hasMatch("966" + data)) {
      error = " برجاء ادخال رقم سعودي";
      return error;
    }
    error = 'noError';
    return error;
  }

  String companyDescription(data) {
    if (data != null || data != '') {
      if (!RegExp(r"^[\u0621-\u064AA-Za-z]+$").hasMatch(data)) {
        error = " برجاء ادخال وصف يحتوي على حروف  فقط ";
        return error;
      }
    } else {
      error = 'noError';
    }
    return error;
  }

  String onlyString(data) {
    if (data == null || data == '') {
      error = "لا يمكن ترك هذه الخانة فارغة";
      return error;
    }
    if (data != null || data != '') {
      if (!RegExp(r"^[\u0621-\u064AA-Za-z]+$").hasMatch(data)) {
        error = " برجاء ادخال حروف  فقط ";
        return error;
      }
    } else {
      error = 'noError';
    }
    return error;
  }

  String validatePassword(data) {
    if (data == null || data == '') {
      error = " برجاء ادخال كلمة المرور  صحيحة";
      return error;
    }
    if (data.toString().length < 8 || data.toString().length > 12) {
      error = "كلمة المرور يجب ان نكون  من 8 الي 12 احرف";
      return error;
    }
    error = 'noError';

    return error;
  }

  String commericalRegister(data) {
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
