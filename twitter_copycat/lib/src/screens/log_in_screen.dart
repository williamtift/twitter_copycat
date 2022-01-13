import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
import 'package:twitter_copycat/src/widgets.dart';
import 'forgot_password_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    Key? key,
    required this.logIn,
    required this.forgotPassword,
  }) : super(key: key);

  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
    BuildContext context,
  ) logIn;

  final void Function(
    String email,
    BuildContext context,
  ) forgotPassword;

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

  void _sendRecoveryEmail() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return ForgotPasswordScreen(forgotPassword: widget.forgotPassword);
        },
      ),
    );
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
              forgotPassword: () => _sendRecoveryEmail(),
            ),
          ],
        ));
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({
    required this.logIn,
    required this.forgotPassword,
  });
  final void Function(String, String) logIn;
  final void Function() forgotPassword;

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
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text("Forgot Password?",
                        style: TextStyle(color: Colors.blueAccent)),
                    onTap: () => widget.forgotPassword(),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        BorderSide(color: Colors.blueAccent))),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
