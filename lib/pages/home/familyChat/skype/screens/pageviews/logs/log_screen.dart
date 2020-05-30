import 'package:familyApp/pages/home/familyChat/skype/models/log.dart';
import 'package:familyApp/pages/home/familyChat/skype/resources/local_db/repository/log_repository.dart';
import 'package:familyApp/pages/home/familyChat/skype/utils/universal_variables.dart';
import 'package:flutter/material.dart';
class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Center(
        child: FlatButton(
          child: Text("Click Me"),
          onPressed: () {
            LogRepository.init(isHive: false);
            LogRepository.addLogs(Log());
          },
        ),
      ),
    );
  }
}
