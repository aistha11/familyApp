import 'package:familyApp/model/note.dart';
import 'package:familyApp/pages/home/familyChat/skype/screens/callscreens/pickup/pickup_layout.dart';
import 'package:familyApp/pages/home/familyChat/skype/screens/pageviews/chats/widgets/user_circle.dart';
import 'package:familyApp/pages/home/familyChat/skype/widgets/appbar.dart';
import 'package:familyApp/pages/home/masterList/addMasterNote.dart';
import 'package:familyApp/pages/widgets/notesItem.dart';
// import 'package:familyApp/pages/widgets/listDetail.dart';
import 'package:familyApp/services/db_service.dart';
import 'package:familyApp/utils/func.dart';
import 'package:flutter/material.dart';

class MasterList extends StatelessWidget {
  CustomAppBar customMasterAppBar(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomAppBar(
      leading: UserCircle(),
      title: Text('Master List'),
      centerTitle: false,
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.search,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, "/search_screen");
        //   },
        // ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            Func.toImplement(context, "Get Notifications");
          },
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {
            Func.toImplement(context, "More Options");
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
          scaffold: Scaffold(
        appBar: customMasterAppBar(context),
        body: StreamBuilder(
          stream: masternotesDb.streamList(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasError)
              return Container(
                child: Center(
                  child: Text("There was an error"),
                ),
              );
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: snapshot.data[index],
                  onEdit: (note) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMasterNote(
                            note: note,
                          ),
                        ));
                  },
                  onDelete: (note) async {
                    if (await _confirmDelete(context)) {
                      masternotesDb.removeItem(note.id);
                    }
                  },
                  //
                  onTap: (note) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text(note.title),
                        content: Container(
                          height: 200.0,
                          child: Column(
                            children: [
                              Text('Id : ${note.id}'),
                              Text('Created At : ${note.createdAt}'),
                              Text('User Id : ${note.userId}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/addMasterNote");
          },
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Confirm Delete"),
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ));
  }
}
