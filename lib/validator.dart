class Validator {
  static String? firstName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Enter your first name.';
    }

    return null;
  }

  static String? lastName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Enter your last name.';
    }

    return null;
  }

  static String? email(String? email) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email == null || email.isEmpty) {
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty) {
    } else if (password.length < 6) {
      return 'Enter minimum of 6 characters.';
    }

    return null;
  }
}
