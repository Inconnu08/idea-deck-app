String validateMobile(String value) {
  RegExp regExp = new RegExp(r'(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$');
  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid mobile number';
  }
  return null;
}

String validatepassword(String value) {
  if (value.length < 7) {
    return 'Password is too short.';
  }
  return null;
}

String validateEmail(String value) {
  RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid Email address';
  }
  return null;
}

String validateName(String value) {
  if (value.length < 2) {
    return 'Please enter a valid full name.';
  }
  return null;
}

String validateEmpty(String value) {
  if (value.length < 2) {
    return 'Please enter a valid value.';
  }
  return null;
}
