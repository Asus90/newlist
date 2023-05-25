import 'package:flutter/material.dart';
import 'package:newserver/View/data/data.dart';
import 'package:newserver/View/data/note_model/note_model.dart';

import 'Screen_add_note.dart';

class ScreenAllNotes extends StatelessWidget {
  ScreenAllNotes({Key? key});

//   @override
//   State<ScreenAllNotes> createState() => _ScreenAllNotesState();
// }

// class _ScreenAllNotesState extends State<ScreenAllNotes> {

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await NoteDB.instence.getAllnotes();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Note'),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: NoteDB.instence.noteListNotifire,
        builder: (context, List<NoteModel> newNote, _) {
          print(newNote);
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: List.generate(
              newNote.length,
              (index) {
                final _note = NoteDB.instence.noteListNotifire.value[index];

                if (_note.id == null) {
                  const SizedBox();
                }
                return NotItem(
                    id: _note.id!,
                    title: _note.title ?? "no title",
                    content: _note.content ?? "no content ");
              },
            ),
          );
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ScreenAddNote(type: ActionType.addnote)));
        },
        label: const Text("New"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class NotItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;

  const NotItem({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (ctx) => ScreenAddNote(
                    type: ActionType.editnote,
                    id: id,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color.fromARGB(255, 45, 87, 227)),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            Text(
              content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
