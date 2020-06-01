import 'package:familyApp/pages/home/familyChat/skype/models/contact.dart';
import 'package:familyApp/pages/home/familyChat/skype/models/user.dart';
import 'package:familyApp/pages/home/familyChat/skype/provider/user_provider.dart';
import 'package:familyApp/pages/home/familyChat/skype/resources/auth_methods.dart';
import 'package:familyApp/pages/home/familyChat/skype/resources/chat_methods.dart';
import 'package:familyApp/pages/home/familyChat/skype/screens/chatscreens/chat_screen.dart';
import 'package:familyApp/pages/home/familyChat/skype/screens/chatscreens/widgets/cached_image.dart';
import 'package:familyApp/pages/home/familyChat/skype/screens/pageviews/chats/widgets/online_dot_indicator.dart';
import 'package:familyApp/pages/home/familyChat/skype/utils/universal_variables.dart';
import 'package:familyApp/pages/home/familyChat/skype/widgets/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'last_message_container.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: true,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        (contact != null ? contact.name : null) != null ? contact.name : "..",
        style:
            TextStyle(color: UniversalVariables.titCol, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 50,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid,
            ),
          ],
        ),
      ),
    );
  }
}
