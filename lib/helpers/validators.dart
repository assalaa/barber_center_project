class Validators {
  static RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "E-mail can't be empty";
    } else if (!emailRegExp.hasMatch(value)) {
      return 'E-mail format is not valid';
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value!.isEmpty) {
      return "Username can't be empty";
    } else if (value.length < 6) {
      return 'Username is too short';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return 'Password is too short';
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone number can't be empty";
    } else if (value.length < 11) {
      return 'Phone number is too short';
    }
    return null;
  }
}
