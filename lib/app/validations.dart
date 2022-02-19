import 'package:flutter/cupertino.dart';

class Validations {
  static String? validateName(String name, BuildContext context) {
    String? validateString = '';
    Pattern pattern = r'[a-zA-Zء-ي]';
    RegExp regex = RegExp(pattern.toString());
    if (name.trim().isEmpty) {
      validateString = "empty field";
    } else if (!regex.hasMatch(name.trim()) && name.trim().length <= 15) {
      validateString = "invalid data";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateEmail(String email, BuildContext context) {
    String? validateString;
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    if (email.trim().isEmpty) {
      validateString = null;
    } else if (!regex.hasMatch(email.trim())) {
      validateString = "invalid data";
    }
    return validateString;
  }

  static String? validatePhone(String phone, BuildContext context) {
    String? validateString = '';
    // Pattern pattern = r'(^(?:[+0]9)?[0-9]{13}$)';
    //  RegExp regex = new RegExp(pattern);
    if (phone.trim().isEmpty) {
      validateString = "empty field";
    } else if (phone.trim().length != 9) {
      validateString = "invalid data";
    }
    // else if (phone.trim().toString() == exist) {
    //   validateString = S.of(context).existphone;
    // }
    // else if (phone.trim().toString() != exist) {
    //   validateString = S.of(context).notexistphone;
    // }
    // else if (!regex.hasMatch(phone.trim())) {
    //   validateString = S.of(context).invphone;
    // }
    else {
      validateString = null;
    }
    return validateString;
  }


  static String? validateNationalId(String phone, BuildContext context) {
    String? validateString = '';
    // Pattern pattern = r'(^(?:[+0]9)?[0-9]{13}$)';
    //  RegExp regex = new RegExp(pattern);
    if (phone.trim().isEmpty) {
      validateString = "empty field";
    } else if (phone.trim().length != 10) {
      validateString = "must be 10 digits";
    }
    // else if (phone.trim().toString() == exist) {
    //   validateString = S.of(context).existphone;
    // }
    // else if (phone.trim().toString() != exist) {
    //   validateString = S.of(context).notexistphone;
    // }
    // else if (!regex.hasMatch(phone.trim())) {
    //   validateString = S.of(context).invphone;
    // }
    else {
      validateString = null;
    }
    return validateString;
  }

  static String? validatePassword(String password, BuildContext context) {
    String? validateString = '';
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern.toString());
    if (password.trim().isEmpty) {
      validateString = "empty field";
    } /*else if (!regex.hasMatch(password.trim())) {
      validateString = "invalid data";

    }*/

    else if (password.length < 6) {
      validateString = "password must be at least 7 letters";
    }
    else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateField(String value, BuildContext context) {
    String? validateString = '';
    if (value.trim().isEmpty) {
      validateString = "empty field";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateconPassword(
      String password, BuildContext context, String conpass) {
    String? validateString = '';

    if (conpass.trim().isEmpty) {
      validateString = "empty field";
    } else if (password.toString() != conpass.toString()) {
      validateString = "password doesn't match";
    } else {
      validateString = null;
    }
    return validateString;
  }
}
