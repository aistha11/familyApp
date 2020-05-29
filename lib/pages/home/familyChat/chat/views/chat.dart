// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familyApp/pages/home/familyChat/chat/helper/constants.dart';
import 'package:familyApp/pages/home/familyChat/chat/services/database.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String username;

  Chat({this.chatRoomId, @required this.username});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].data["message"],
                    sendByMe: Constants.myName ==
                        snapshot.data.documents[index].data["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  Widget typeMessage() {
    return Container(
      // alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
        color: Colors.white30,
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: messageEditingController,
              // style: simpleTextStyle(),
              decoration: InputDecoration(
                  hintText: "Message ...",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  border: InputBorder.none),
            )),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                addMessage();
              },
              child: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('${widget.username}'),
      ),
      body: Container(
        child: Stack(
          // fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: chatMessages(),
            ),
            typeMessage(),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 9, bottom: 9, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [
                      Colors.blue,
                      Colors.blueAccent,
                    ]
                  : [
                      Colors.grey[700],
                      Colors.grey[600],
                    ],
            )),
        child: Expanded(
          child: Text(message,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: sendByMe ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
