// import 'dart:js';
import 'package:familyApp/pages/home/familyChat/chat/views/chatrooms.dart';
// import 'package:familyApp/pages/home/familyChat/familyChat.dart';
import 'package:familyApp/pages/home/masterList/masterList.dart';
import 'package:familyApp/pages/home/ourFamily/ourFamily.dart';
import 'package:familyApp/pages/home/personalList/personalList.dart';
import 'package:familyApp/pages/home/profile/profile.dart';
import 'package:familyApp/pages/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final _tabPages = [
      MasterList(),
      PersonalList(),
      // FamilyChat(),
      ChatRoom(),
      Profile(),
      OurFamily(),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.person_pin),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () {},
            ),
          ],
        ),
        body: _tabPages[currentIndex],
        floatingActionButton: currentIndex != 2 ?  FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            if(currentIndex == 0)
              Navigator.pushNamed(context, "/addMasterNote");
            if(currentIndex == 1)
              Navigator.pushNamed(context, "/addPersonalNote");
          },
        ) : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.view_list), title: Text('Master List')),
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_list), title: Text('Personal List')),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), title: Text('Family Chat')),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
