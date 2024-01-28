import 'package:dsw_aplikacje_mobilne_projekt/models/note_model.dart';
import 'package:dsw_aplikacje_mobilne_projekt/screens/note_screen.dart';
import 'package:dsw_aplikacje_mobilne_projekt/services/db_service.dart';
import 'package:dsw_aplikacje_mobilne_projekt/widgets/note_widget.dart';
import 'package:flutter/material.dart';

class NoteListWidget extends StatefulWidget {
  const NoteListWidget({super.key});

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>?>(
      future: DatabaseService.getAllNotes(),
      builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) => NoteWidget(
                note: snapshot.data![index],
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(
                        note: snapshot.data![index],
                      ),
                    ),
                  );
                  setState(() {});
                },
                onLongPress: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            'Are you sure you want to delete this note?'),
                        actions: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              await DatabaseService.deleteNote(
                                  snapshot.data![index]);
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: const Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              itemCount: snapshot.data!.length,
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
