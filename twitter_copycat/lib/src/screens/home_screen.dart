import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../datatypes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.usuario,
      required this.publicarTweet,
      required this.signOut})
      : super(key: key);

  final DtUsuario usuario;
  final void Function(
    String tweet,
  ) publicarTweet;
  final void Function() signOut;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _generarOpcionesDrawer() {
    return <Widget>[
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Sign out'),
        onTap: () {
          widget.signOut();
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Otra opcion 1'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.group),
        title: Text('Otra opcion 2'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text('Etc'),
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: FaIcon(FontAwesomeIcons.twitter,
              color: Colors.blueAccent, size: 35),
        ),
        //Drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
                  DrawerHeader(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () => {
                              Navigator.of(context).pop(),
                            },
                            iconSize: 30.0,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ] +
                _generarOpcionesDrawer(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Text("Hola"),
          ],
        ));
  }
}
