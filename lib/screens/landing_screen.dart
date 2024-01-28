import 'package:dsw_aplikacje_mobilne_projekt/screens/note_screen.dart';
import 'package:dsw_aplikacje_mobilne_projekt/widgets/note_list_widget.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() {
    return _LandingScreenState();
  }
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Image(
          image: AssetImage("assets/images/landing_background.png"),
        ),
        const Center(
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            height: 250,
            fit: BoxFit.fitHeight,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteScreen(),
                ),
              );
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          body: NoteListWidget(),
        ),
      ],
    );
  }
}
