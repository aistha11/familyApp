import 'package:familyApp/enum/auth_state.dart';
import 'package:familyApp/pages/auth/loginPage.dart';
import 'package:familyApp/pages/home/home.dart';
import 'package:familyApp/pages/widgets/splash.dart';
import 'package:familyApp/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthMethods user, _) {
      switch (user.status) {
        case Status.Uninitialized:
          return Splash();
        case Status.Unauthenticated:
        case Status.Authenticating:
          return Login();
        case Status.Authenticated:
          return Home();
        default:
          return Splash();
      }
    });
  }
}
