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

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        if (FirebaseAuth.instance.currentUser!.displayName != null) {
          //Esta condicion esta porque una vez creas un usuario, demora en guardarse los datos en la base de datos
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String name = FirebaseAuth.instance.currentUser!.displayName!;
        String email = FirebaseAuth.instance.currentUser!.email!;

        _usuarioSubscription = FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .snapshots()
            .listen((document) {
          _usuario =
              DtUsuario(uid, name, email, document.data()!['birthDate'] as String);
        });
        }
      } else {
        _usuarioSubscription?.cancel();
        _usuario = null;
      }
      notifyListeners();
    });
  }

  DtUsuario? _usuario;
  DtUsuario? get usuario => _usuario;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _usuarioSubscription;

  void logIn(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
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

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void publicarTweet(String tweet) {}
}
