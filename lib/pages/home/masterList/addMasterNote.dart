import 'package:familyApp/models/note.dart';
import 'package:familyApp/resources/auth_methods.dart';
import 'package:familyApp/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMasterNote extends StatefulWidget {
  final Note note;

  const AddMasterNote({Key key, this.note}) : super(key: key);
  @override
  _AddMasterNoteState createState() => _AddMasterNoteState();
}

class _AddMasterNoteState extends State<AddMasterNote> {
  TextEditingController _titleController;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _editMode;
  bool _processing;
  @override
  void initState() {
    super.initState();
    _processing = false;
    _editMode = widget.note != null;
    _titleController =
        TextEditingController(text: _editMode ? widget.note.title : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.clear, size: 29.0, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Add to Master List'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 10.0),
            RaisedButton(
              child: _processing ? CircularProgressIndicator() : Text("Save"),
              onPressed: _processing
                  ? null
                  : () async {
                      setState(() {
                        _processing = true;
                      });
                      if (_titleController.text.isEmpty) {
                        _key.currentState.showSnackBar(SnackBar(
                          content: Text("Title is required."),
                        ));
                        return;
                      }
                      Note note = Note(
                        id: _editMode ? widget.note.id : null,
                        title: _titleController.text,
                        createdAt: DateTime.now(),
                        userId:
                            Provider.of<AuthMethods>(context, listen: false)
                                .user
                                .uid,
                      );
                      if (_editMode) {
                        await masternotesDb.updateItem(note);
                      } else {
                        await masternotesDb.createItem(note);
                      }
                      Navigator.pop(context);
                    },
            )
          ],
        ),
      ),
    );
  }
}
