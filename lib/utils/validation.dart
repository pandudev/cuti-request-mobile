class Validation {
  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }

  String validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Password harus sama';
    }

    return null;
  }

  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Email tidak valid';
    }

    return null;
  }

  String validateString(String value) {
    if (value.isEmpty) {
      return "Field wajib diisi";
    }

    return null;
  }

  String validateDate(String value) {
    if (value.isEmpty) {
      return "Tanggal wajib dipilih";
    }

    return null;
  }
}
