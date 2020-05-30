class Func {
  static String getUsername(String email) {
    return "${email.split('@')[0]}";
  }
}