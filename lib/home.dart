import 'package:flutter/material.dart';
import 'package:idea_deck/button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idea Deck',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Idea Deck'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ThemeButton(
        text: "Button",
        color: Colors.lightGreen,
        ontap: () => print("yes!"),
      ),
    );
  }
}
