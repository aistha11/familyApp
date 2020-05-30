import 'package:familyApp/pages/home/familyChat/skype/models/user.dart';
import 'package:familyApp/pages/home/familyChat/skype/resources/auth_methods.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  User _user;
  AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}
