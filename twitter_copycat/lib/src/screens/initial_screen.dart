import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../logica.dart';

import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen(
      {Key? key,
      })
      : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FaIcon(FontAwesomeIcons.twitter, color: Colors.blueAccent),
        ),
        body: Text("See what's happening in the world right now.") );
  }
}
