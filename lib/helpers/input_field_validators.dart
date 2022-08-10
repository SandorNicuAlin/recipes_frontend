class InputFieldValidators {
  static String? checkIfEmpty(String? value, {errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 3) {
      return 'Username must have 3 or more characters';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 4) {
      return 'Password must have 4 or more characters';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value,
      {passwordController, confirmPasswordController}) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (passwordController.value.text != confirmPasswordController.value.text) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  static String? groupNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name for the group';
    }
    if (value.length < 2) {
      return 'Username must have 2 or more characters';
    }
    return null;
  }
}
