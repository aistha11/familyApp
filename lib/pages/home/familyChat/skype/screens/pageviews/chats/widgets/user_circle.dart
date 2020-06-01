import 'package:familyApp/pages/home/familyChat/skype/provider/user_provider.dart';
import 'package:familyApp/pages/home/familyChat/skype/utils/universal_variables.dart';
import 'package:familyApp/pages/home/familyChat/skype/utils/utilities.dart';
import 'package:familyApp/utils/func.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_details_container.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      // onTap: () => showModalBottomSheet(
      //   isScrollControlled: true,
      //   context: context,
      //   backgroundColor: UniversalVariables.blackColor,
      //   builder: (context) => UserDetailsContainer(),
      // ),
      onTap: (){
        Func.toImplement(context, "Navigate to profile page");
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: UniversalVariables.separatorColor,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getInitials(userProvider.getUser.name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UniversalVariables.lightBlueColor,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: UniversalVariables.blackColor, width: 2),
                    color: UniversalVariables.onlineDotColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
