import 'package:familyApp/pages/widgets/ourFamily.dart';
import 'package:familyApp/pages/widgets/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {

    
    final _tabs = [
      Tab(
        text: 'Profile',
        icon: Icon(Icons.person_pin),
      ),
      Tab(
        text: 'Our Family',
        icon: Icon(Icons.people),
      ),
    ];

    final _tabPages = [Profile(), OurFamily()];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(tabs: _tabs),
        ),
        body: TabBarView(children: _tabPages),
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
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
