import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
import 'package:twitter_copycat/src/widgets.dart';
import '../datatypes.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    Key? key,
    required this.logIn,
  }) : super(key: key);

  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
    BuildContext context,
  ) logIn;

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return CartelProblema(title, '${(e as dynamic).message}');
        });
  }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleCreateAndLoginScreens("Log into your account"),
            LogInForm(
              logIn: (
                email,
                password,
              ) {
                widget.logIn(
                    email,
                    password,
                    (e) => _showErrorDialog(context, 'Failed to log in', e),
                    context);
              },
            ),
          ],
        ));
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({
    required this.logIn,
  });
  final void Function(String, String) logIn;
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_LogInFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    style: TextStyle(color: Colors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: colorGrisDeImagenPrueba)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: colorGrisDeImagenPrueba)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: colorGrisDeImagenPrueba)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: colorGrisDeImagenPrueba)),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password to continue';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blueAccent))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.logIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      child: Text('Log in'),
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
