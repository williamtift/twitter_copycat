import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
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
    ];
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Search',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Notifications',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Messages',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        elevation: 2,
        title: FaIcon(FontAwesomeIcons.twitter,
            size: 35),
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
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined),
            label: "",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: colorGrisDeImagenPrueba,
        iconSize: 32,
        onTap: _onItemTapped,
      ),
    );
  }
}
