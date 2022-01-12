import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_copycat/src/colores.dart';
import 'package:twitter_copycat/src/widgets.dart';
import '../datatypes.dart';

class CrearCuentaScreen extends StatefulWidget {
  const CrearCuentaScreen({
    Key? key,
    required this.createAccount,
  }) : super(key: key);

  final void Function(
    DtUsuario usuario,
    String password,
    void Function(Exception e) error,
    BuildContext context,
  ) createAccount;

  @override
  _CrearCuentaScreenState createState() => _CrearCuentaScreenState();
}

class _CrearCuentaScreenState extends State<CrearCuentaScreen> {
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
            TitleCreateAndLoginScreens("Create your account"),
            RegisterForm(
              registerAccount: (
                usuario,
                password,
              ) {
                widget.createAccount(
                    usuario,
                    password,
                    (e) => _showErrorDialog(
                        context, 'Failed to create account', e),
                    context);
              },
            ),
          ],
        ));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.registerAccount,
  });
  final void Function(DtUsuario, String) registerAccount;
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime? _selectedDate;
  final _passwordController = TextEditingController();
  final _verifyPasswordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2200));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

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
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                  child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    style: TextStyle(color: Colors.white),
                    controller: _nameController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: colorGrisDeImagenPrueba)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        hintText: 'Name',
                        hintStyle: TextStyle(color: colorGrisDeImagenPrueba)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your name to continue';
                      }
                      return null;
                    },
                  ),
                ),
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
                        hintText: 'Email address',
                        hintStyle: TextStyle(color: colorGrisDeImagenPrueba)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _selectedDate != null
                            ? _selectedDate!.toLocal().toString().split(' ')[0]
                            : "Date of birth",
                        style: TextStyle(
                            fontSize: 16,
                            color: _selectedDate != null
                                ? Colors.white
                                : colorGrisDeImagenPrueba),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        onPressed: () => _selectDate(context),
                        iconSize: 25.0,
                        icon: Icon(
                          Icons.edit,
                          color: colorGrisDeImagenPrueba,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: colorGrisDeImagenPrueba,
                  height: 10,
                  thickness: 0.9,
                  indent: 22,
                  endIndent: 22,
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
                        return 'Enter your desired password to continue';
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
                   Padding(padding: EdgeInsets.only(top: 40), child: 
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
                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null) {
                        widget.registerAccount(
                          DtUsuario(
                              "",
                              _nameController.text,
                              _emailController.text,
                              _selectedDate!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]),
                        _passwordController.text,
                        );
                      }
                    },
                    child:Text('Create'),
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
