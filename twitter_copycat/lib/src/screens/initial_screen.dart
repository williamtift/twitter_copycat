import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
import 'package:twitter_copycat/src/widgets.dart';
import '../logica.dart';

import 'package:provider/provider.dart';
import '../../firebase_options.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: FaIcon(FontAwesomeIcons.twitter,
              color: Colors.blueAccent, size: 35),
        ),
        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
        body: Column(
          children: [
            TextoInitialScreen("See what's happening in the world right now."),
            BloqueDeBotones(),
          ],
        ));
  }
}
