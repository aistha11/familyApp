import 'package:familyApp/pages/home/familyChat/chatscreens/widgets/cached_image.dart';
import 'package:familyApp/provider/user_provider.dart';
import 'package:familyApp/utils/universal_variables.dart';
import 'package:familyApp/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCircle extends StatefulWidget {
  @override
  _UserCircleState createState() => _UserCircleState();
}

class _UserCircleState extends State<UserCircle> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    var user = userProvider.getUser;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/profile");
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
              child: user.profilePhoto == null
                  ? Text(
                      Utils.getInitials(user.name),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: UniversalVariables.lightBlueColor,
                        fontSize: 14,
                      ),
                    )
                  : CachedImage(
                      user.profilePhoto,
                      isRound: true,
                      radius: 45,
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
