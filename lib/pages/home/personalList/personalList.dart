import 'package:familyApp/model/note.dart';
import 'package:familyApp/pages/home/personalList/addPersonalNote.dart';
import 'package:familyApp/pages/widgets/notesItem.dart';
// import 'package:familyApp/pages/widgets/listDetail.dart';
import 'package:familyApp/services/db_service.dart';
import 'package:flutter/material.dart';

class PersonalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: personalnotesDb.streamList(),
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.hasError)
          return Container(
            child: Center(
              child: Text("There was an error"),
            ),
          );
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return NoteItem(
              note: snapshot.data[index],
              onEdit: (note) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddPersonalNote(
                        note: note,
                      ),
                    ));
              },
              onDelete: (note) async {
                if (await _confirmDelete(context)) {
                  personalnotesDb.removeItem(note.id);
                }
              },
              // onTap: (note) => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => NoteDetailsPage(
              //             note: note,
              //           ),
              //         )),
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
