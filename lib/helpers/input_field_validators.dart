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
      return 'The username must have 3 or more characters';
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
      return 'The password must have 4 or more characters';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value,
      {passwordController, confirmPasswordController}) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (passwordController.value.text != confirmPasswordController.value.text) {
      return 'The passwords don\'t match';
    }
    return null;
  }

  static String? groupNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name for the group';
    }
    if (value.length < 2) {
      return 'The username must have 2 or more characters';
    }
    return null;
  }

  static String? productNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length > 30) {
      return 'The name can have maximum 30 characters';
    }
    return null;
  }

  static String? productQuantityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the quantity';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a numeric value';
    }
    if (double.parse(value) <= 0 || double.parse(value) > 10000) {
      return 'Please enter a valid value';
    }
    return null;
  }

  static String? recipeNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name for the recipe';
    }
    if (value.length < 2 || value.length > 30) {
      return 'The name must be between 2 and 30 characters long';
    }
    return null;
  }

  static String? recipeStepNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name for the recipe step';
    }
    if (value.length < 2 || value.length > 25) {
      return 'The name must be between 2 and 25 characters long';
    }
    return null;
  }
}
