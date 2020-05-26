import 'package:familyApp/model/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {

  final UserRepository _auth = UserRepository.instance();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('apar.firebase@gmail.com'),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Rate Us'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text('Log Out'),
            onTap: () {
              _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
