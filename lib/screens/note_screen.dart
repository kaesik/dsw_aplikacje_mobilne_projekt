import 'package:dsw_aplikacje_mobilne_projekt/database/note_db.dart';
import 'package:dsw_aplikacje_mobilne_projekt/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;
  const NoteScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          note == null ? 'Add a note' : 'Edit note',
          style: const TextStyle(
            color: Color(0xFF471AA0),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'What are you thinking about?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Note title',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF9747FF), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF471AA0), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Type the note here',
                labelText: 'Note description',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9747FF), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF471AA0), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final title = titleController.value.text;
                    final description = descriptionController.value.text;

                    if (title.isEmpty || description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all the fields'),
                        ),
                      );
                      return;
                    }

                    final Note model = Note(
                        title: title, description: description, id: note?.id);
                    if (note == null) {
                      await NoteDatabase.addNote(model);
                    } else {
                      await NoteDatabase.updateNote(model);
                    }

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color(0xFFBB84E8),
                  ),
                  child: Text(
                    note == null ? 'Save' : 'Edit',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
