class Validator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );

    if (!emailRegExp.hasMatch(email)) {
      return 'Invalid email format';
    }

    return null; // No validation error
  }

  static String? validatePassword(String password) {
    /*String pattern =
        r"(^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&.*':;€#])[A-Za-z\d@$!%*?&.*':;€#]{6,}$)";
    RegExp regExp = new RegExp(pattern);*/
    if (password.isEmpty) {
      return "Enter Password";
    } else if (password.length < 6 || password.length > 30) {
      return "The default is 6 characters. The maximum is 30 characters";
    } /*else if (!regExp.hasMatch(password)) {
      return "Must mix numbers, special characters, uppercase and lowercase letters";
    }*/
    return null;
  }

  static String? validateConfirmPassword(String password, String cPassword) {
    if (cPassword.isEmpty)
      return 'Enter Confirm Password';
    else if (cPassword != password)
      return "Confirm password doesn't match with Password";
    else
      return null;
  }

  static String? textFieldValidation(String value, String msg) {
    String pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-.]';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty)
      return msg;
    else if (regex.hasMatch(value))
      return "Invalid Text";
    else if (value.length < 3)
      return msg;
    else
      return null;
  }

  emptyFieldValidation(String value, String msg) {
    String pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-.]';
    RegExp regex = new RegExp(pattern);
    print("$regex");
    if (value.isEmpty)
      return msg;
    else if (value.length < 3)
      return msg;
    else
      return null;
  }

  static String? validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty)
      return 'Mobile Number required';
    else if (!regExp.hasMatch(value))
      return "Mobile Number required";
    else if (value.length != 10)
      return "Mobile Number required";
    else
      return null;
  }

  static String? validateOrderId(String value) {
    String pattern = r'(^[0-9a-zA-z-]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty)
      return 'Enter OrderId';
    else if (!regExp.hasMatch(value))
      return "Enter valid OrderId";
    else
      return null;
  }

  static String? validateEmailAndMobile(String? value) {
    if (value!.isEmpty) {
      return "Enter Email/Mobile";
    } else if (value.length > 2) {
      if (isNumeric(value)) {
        return validateMobile(value);
      } else {
        return validateEmail(value);
      }
    } else {
      return null;
    }
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    try {
      return double.parse(s) != null;
    } catch (e) {
      print("Error: $e");

      return false;
    }
  }

  bool isValidDate(String input) {
    final date = DateTime.parse(input);
    final originalFormatString = toOriginalFormatString(date);
    return input == originalFormatString;
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }
}
