import 'package:familyApp/models/user.dart';
import 'package:familyApp/pages/home/familyChat/chatscreens/chat_screen.dart';
import 'package:familyApp/pages/widgets/custom_tile.dart';
import 'package:familyApp/resources/auth_methods.dart';
import 'package:familyApp/utils/universal_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AuthMethods _authMethods = AuthMethods.instance();

  List<User> userList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _authMethods.getCurrentUser().then((FirebaseUser user) {
      _authMethods.fetchAllUsers(user).then((List<User> list) {
        setState(() {
          userList = list;
        });
      });
    });
  }

  searchAppBar(BuildContext context) {
    return AppBar(
      // gradient: LinearGradient(
      //   colors: [
      //     UniversalVariables.gradientColorStart,
      //     UniversalVariables.gradientColorEnd,
      //   ],
      // ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Search'),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 15),
        child: Container(
          padding: EdgeInsets.only(left:20 , top: 10.0, right: 20.0, bottom: 10.0),
          color: UniversalVariables.scfBgColor,
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: UniversalVariables.blackColor,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 19,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.black38,),
              contentPadding: EdgeInsets.all(5),
              filled: true,
              fillColor: Colors.white38,
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear());
                },
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              hintText: "@username",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    final List<User> suggestionList = query.isEmpty
        ? []
        : userList != null
            ? userList.where((User user) {
                String _getUsername = user.username.toLowerCase();
                String _query = query.toLowerCase();
                String _getName = user.name.toLowerCase();
                bool matchesUsername = _getUsername.contains(_query);
                bool matchesName = _getName.contains(_query);

                return (matchesUsername || matchesName);

                // (User user) => (user.username.toLowerCase().contains(query.toLowerCase()) ||
                //     (user.name.toLowerCase().contains(query.toLowerCase()))),
              }).toList()
            : [];

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        User searchedUser = User(
            uid: suggestionList[index].uid,
            profilePhoto: suggestionList[index].profilePhoto,
            name: suggestionList[index].name,
            username: suggestionList[index].username);

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiver: searchedUser,
                        )));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser.profilePhoto),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              color: UniversalVariables.titCol,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.name,
            style: TextStyle(color: UniversalVariables.lastMsgCol),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: UniversalVariables.scfBgColor,
        appBar: searchAppBar(context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: buildSuggestions(query),
        ),
      );
  }
}
