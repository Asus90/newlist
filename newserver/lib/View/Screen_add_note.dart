import 'package:flutter/material.dart';
import 'package:newserver/View/data/data.dart';

import 'package:newserver/View/data/note_model/note_model.dart';

enum ActionType { addnote, editnote }

class ScreenAddNote extends StatelessWidget {
  final ActionType type;
  String? id;

  ScreenAddNote({Key? key, required this.type, this.id}) : super(key: key);

  String _getTitle() {
    switch (type) {
      case ActionType.addnote:
        return 'ADD NOTE';
      case ActionType.editnote:
        return 'EDIT NOTE';
    }
  }

  Widget get saveButton => TextButton.icon(
        onPressed: () {
          switch (type) {
            case ActionType.addnote:
              Savenote();

              break;
            case ActionType.editnote:
              // TODO: Handle editnote action
              break;
          }
        },
        icon: Icon(Icons.save),
        label: Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
      );

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_getTitle().toUpperCase()),
        actions: [
          saveButton,
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                maxLength: 100,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Content",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Savenote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    final _newnote = NoteModel.create(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        content: content);

    final _newNote = await NoteDB().CreateNote(_newnote);
    if (_newNote != null) {
      print("Note saved");

      Navigator.of(_scaffoldKey.currentContext!).pop();
    } else {
      print('erro while saving note');
    }
  }
}
