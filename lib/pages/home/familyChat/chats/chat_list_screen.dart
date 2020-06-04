import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familyApp/models/contact.dart';
import 'package:familyApp/pages/home/familyChat/chats/widgets/contact_view.dart';
import 'package:familyApp/pages/home/familyChat/chats/widgets/quiet_box.dart';
// import 'package:familyApp/pages/widgets/appbar.dart';
import 'package:familyApp/provider/user_provider.dart';
import 'package:familyApp/resources/chat_methods.dart';
// import 'package:familyApp/utils/func.dart';
import 'package:familyApp/utils/universal_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'widgets/new_chat_button.dart';
// import 'widgets/user_circle.dart';

class ChatListScreen extends StatelessWidget {
  // CustomAppBar customAppBar(BuildContext context) {
  //   // final UserProvider userProvider = Provider.of<UserProvider>(context);

  //   return CustomAppBar(
  //     leading: UserCircle(),
  //     title: Text('Chat'),
  //     centerTitle: false,
  //     actions: <Widget>[
  //       IconButton(
  //         icon: Icon(
  //           Icons.notifications,
  //           color: Colors.white,
  //         ),
  //         onPressed: () {
  //           Func.toImplement(context, "Get Notifications");
  //         },
  //       ),
  //       IconButton(
  //         icon: Icon(
  //           Icons.more_vert,
  //           color: Colors.white,
  //         ),
  //         onPressed: () {
  //           Func.toImplement(context, "More Options");
  //         },
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: UniversalVariables.scfBgColor,
        // appBar: customAppBar(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, "/search_screen");
          },
        ),
        body: ChatListContainer(),
      );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
