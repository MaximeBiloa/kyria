import 'package:flutter/material.dart';
import 'package:kyria/providers/models/discussion_model.dart';
import 'package:kyria/screens/inbox_screen.dart';
import 'package:kyria/utils/colors.dart';

class Welcome extends StatefulWidget {
  Welcome({required this.themeMode});
  bool themeMode;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: greenColor,
        child: Image.asset('assets/images/welcomekyria.png', width: 30),
        tooltip: 'Écrire au support de Kyria',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => InboxScreen(
                        currentDiscussion: defaultKyriaDiscussion,
                        discussionType: 0,
                      )));
        },
      ),
    );
  }
}
