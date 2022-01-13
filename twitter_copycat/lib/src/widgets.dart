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

class TitleCreateAndLoginScreens extends StatelessWidget {
  const TitleCreateAndLoginScreens(this.texto);
  final String texto;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(40),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(
          texto,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ));
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

class CartelProblema extends StatelessWidget {
  const CartelProblema(this.titulo, this.mensaje);
  final String titulo;
  final String mensaje;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                mensaje,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          StyledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      );
}

class CartelCargando extends StatelessWidget {
  const CartelCargando();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
          "Loading...",
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Your account is being created.',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
}

class TweetTile extends StatefulWidget {
  const TweetTile({
    Key? key,
    required this.name,
    required this.tweet,
  }) : super(key: key);

  final String name;
  final String tweet;

  @override
  _TweetTileState createState() => _TweetTileState();
}

class _TweetTileState extends State<TweetTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle, size: 50),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Icon(Icons.more_horiz),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, bottom: 10),
            child: Text(
              widget.tweet,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FaIcon(
              FontAwesomeIcons.comment,
              size: 16,
              color: colorGrisDeImagenPrueba,
            ),
            FaIcon(FontAwesomeIcons.retweet,
                size: 16, color: colorGrisDeImagenPrueba),
            FaIcon(FontAwesomeIcons.heart,
                size: 16, color: colorGrisDeImagenPrueba),
            FaIcon(FontAwesomeIcons.externalLinkAlt,
                size: 16, color: colorGrisDeImagenPrueba),
          ],
        ),
      ),
    );
  }
}
