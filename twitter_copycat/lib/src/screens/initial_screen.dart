import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
import 'package:twitter_copycat/src/widgets.dart';
import '../logica.dart';
import 'crear_cuenta_screen.dart';
import 'log_in_screen.dart';
import 'home_screen.dart';

import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  void _crearCuenta() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Consumer<ApplicationState>(
            builder: (context, appState, _) =>
                CrearCuentaScreen(createAccount: appState.createAccount),
          );
        },
      ),
    );
  }

  void _iniciarSesion() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Consumer<ApplicationState>(
            builder: (context, appState, _) =>
                LogInScreen(logIn: appState.logIn),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      if (appState.usuario != null) {
        return HomeScreen(usuario: appState.usuario!, publicarTweet: appState.publicarTweet, signOut: appState.signOut);
      } else {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: FaIcon(FontAwesomeIcons.twitter,
                  color: Colors.blueAccent, size: 35),
            ),
            backgroundColor: Color.fromRGBO(18, 18, 18, 1),
            body: Column(
              children: [
                TextoInitialScreen(
                    "See what's happening in the world right now."),
                BloqueDeBotones(
                    crearCuenta: _crearCuenta, iniciarSesion: _iniciarSesion),
              ],
            ));
      }
    });
  }
}

class BloqueDeBotones extends StatelessWidget {
  const BloqueDeBotones({
    Key? key,
    required this.crearCuenta,
    required this.iniciarSesion,
  }) : super(key: key);

  final void Function() crearCuenta;
  final void Function() iniciarSesion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google,
                            color: Colors.orange, size: 20),
                        TextoBotonesInitialScreen(
                            "Sign in with Google", Colors.black)
                      ],
                    ),
                  )
                ],
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DividerGris(),
            Text(
              "Or",
              style: TextStyle(color: colorGrisDeImagenPrueba),
            ),
            DividerGris(),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blueAccent))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent)),
              onPressed: () => crearCuenta(),
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                          child: TextoBotonesInitialScreen(
                              "Create Account", Colors.white)))
                ],
              )),
        ),
        //Opcion de logueo
        Padding(
            padding: EdgeInsets.only(top: 50, bottom: 20, left: 40),
            child: Row(children: [
              Text(
                "Have an account already? ",
                style: TextStyle(color: colorGrisDeImagenPrueba),
              ),
              GestureDetector(
                child:
                    Text(" Log in", style: TextStyle(color: Colors.blueAccent)),
                onTap: () => iniciarSesion(),
              ),
            ])),
      ],
    );
  }
}
