import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).primaryColor)),
        onPressed: onPressed,
        child: child,
      );
}

class TextoInitialScreen extends StatelessWidget {
  const TextoInitialScreen(this.texto);
  final String texto;

  @override
  Widget build(BuildContext context) => Expanded(
      child: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  texto,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ))));
}

class TextoBotonesInitialScreen extends StatelessWidget {
  const TextoBotonesInitialScreen(this.texto, this.unColor);
  final String texto;
  final Color? unColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(bottom: 2.0, top: 2.0, left: 10, right: 10.0),
        child: Text(
          texto,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: unColor),
        ),
      );
}

class DividerGris extends StatelessWidget {
  const DividerGris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Divider(
            height: 20,
            color: colorGrisDeImagenPrueba,
          )),
    );
  }
}

class BloqueDeBotones extends StatelessWidget {
  const BloqueDeBotones({Key? key}) : super(key: key);

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
              onPressed: () {},
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
                  child: Text(" Log in",
                      style: TextStyle(color: Colors.blueAccent)),
                  onTap: () {}),
            ])),
      ],
    );
  }
}
