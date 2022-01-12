import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'datatypes.dart';
import 'widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) {});
  }

  void createAccount(
      DtUsuario usuario,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      BuildContext context) async {
    try {
      showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const CartelCargando();
          });

      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: usuario.email, password: password);

      await credential.user!.updateDisplayName(usuario.name);

      Navigator.of(context).pop();
      Navigator.of(context).pop();

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(credential.user!.uid)
          .set({
        'name': usuario.name,
        'birthDate': usuario.fecha,
        'email': usuario.email,
      });
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
}
