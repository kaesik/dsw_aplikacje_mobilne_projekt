import 'package:dsw_aplikacje_mobilne_projekt/screens/login_screen.dart';
import 'package:dsw_aplikacje_mobilne_projekt/screens/note_screen.dart';
import 'package:dsw_aplikacje_mobilne_projekt/widgets/note_list_widget.dart';
import 'package:dsw_aplikacje_mobilne_projekt/widgets/user_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() {
    return _LandingScreenState();
  }
}

class _LandingScreenState extends State<LandingScreen> {
  bool _isSwitched = false;

  Widget content = const NoteListWidget();

  void switchContent() {
    setState(() {
      if (_isSwitched == false) {
        content = const NoteListWidget();
      } else {
        content = const UserListWidget();
      }
    });
  }

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
          appBar: AppBar(
            title: Text(
              _isSwitched ? 'Users' : 'Notes',
              style: const TextStyle(
                color: Color(0xFF471AA0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF471AA0),
                size: 20,
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLogin', false);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
            actions: [
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                  switchContent();
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteScreen(),
                ),
              );
              setState(() {
                _isSwitched = false;
                content = const NoteListWidget();
              });
            },
            child: const Icon(Icons.add),
          ),
          body: content,
        ),
      ],
    );
  }
}
