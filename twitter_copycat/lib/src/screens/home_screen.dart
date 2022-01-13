import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
import '../datatypes.dart';
import '../widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.usuario,
      required this.tweets,
      required this.publicarTweet,
      required this.signOut})
      : super(key: key);

  final DtUsuario usuario;
  final List<Tweet> tweets;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Column(
        children: <Widget>[
          for (var tweet in widget.tweets) ...[
            TweetTile(name: tweet.name, tweet: tweet.message),
            Divider(),
          ],
        ],
      ),
      const Center(
        child: Text(
          'Search',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      const Center(
        child: Text(
          'Notifications',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      const Center(
        child: Text(
          'Messages',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        elevation: 2,
        title: FaIcon(FontAwesomeIcons.twitter, size: 35),
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
                              fontWeight: FontWeight.bold),
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
                    const Padding (padding: EdgeInsets.only(top: 2, bottom: 5), child: Text(
                      'Account information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Name:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                            Text(widget.usuario.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Email:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                            Text(widget.usuario.email,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Birth Date:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                            Text(widget.usuario.fecha,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ],
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: <Widget>[
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => PublicarTweetForm(
              publicarTweet: widget.publicarTweet,
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const FaIcon(FontAwesomeIcons.featherAlt),
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

class PublicarTweetForm extends StatefulWidget {
  const PublicarTweetForm({Key? key, required this.publicarTweet})
      : super(key: key);

  final void Function(
    String tweet,
  ) publicarTweet;

  @override
  _PublicarTweetFormState createState() => _PublicarTweetFormState();
}

class _PublicarTweetFormState extends State<PublicarTweetForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PublicarTweetFormState');
  final _tweetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        IconButton(
          onPressed: () => {Navigator.of(context).pop()},
          iconSize: 30.0,
          icon: const Icon(
            Icons.close,
          ),
        ),
        IconButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              widget.publicarTweet(_tweetController.text);
              Navigator.of(context).pop();
            }
          },
          iconSize: 30.0,
          icon: const Icon(
            Icons.done,
            color: Colors.green,
          ),
        ),
      ],
      title: const Text('Publicar tweet'),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _tweetController,
                      decoration: const InputDecoration(
                        hintText: 'Escribe tu tweet...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresar tweet a publicar para continuar.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
