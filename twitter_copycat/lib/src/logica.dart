import 'dart:async';
import 'dart:io';
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
        sleep(Duration(seconds: 1));
        if (FirebaseAuth.instance.currentUser!.displayName != null) {
          //Esta condicion esta porque una vez creas un usuario, demora en guardarse los datos en la base de datos, o cuando te logueas demora en cargarlos

          String uid = FirebaseAuth.instance.currentUser!.uid;
          String name = FirebaseAuth.instance.currentUser!.displayName!;
          String email = FirebaseAuth.instance.currentUser!.email!;

          _usuarioSubscription = FirebaseFirestore.instance
              .collection('usuarios')
              .doc(uid)
              .snapshots()
              .listen((document) {
            _usuario = DtUsuario(
                uid, name, email, document.data()!['birthDate'] as String);
            notifyListeners();
          });
          _tweetsSubscription = FirebaseFirestore.instance
              .collection('tweets')
              .orderBy('timestamp', descending: true)
              .snapshots()
              .listen((snapshot) {
            _tweets = [];
            snapshot.docs.forEach((document) {
              _tweets.add(
                Tweet(
                  name: document.data()['name'] as String,
                  message: document.data()['text'] as String,
                ),
              );
            });
            notifyListeners();
          });
        }
      } else {
        _usuario = null;
        _tweets = [];
      }
      notifyListeners();
    });
  }

  DtUsuario? _usuario;
  DtUsuario? get usuario => _usuario;

  List<Tweet> _tweets = [];
  List<Tweet> get tweets => _tweets;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _usuarioSubscription;
  StreamSubscription<QuerySnapshot>? _tweetsSubscription;

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

  void forgotPassword(String email, BuildContext context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    await showDialog<void>(
        context: context,
        builder: (context) {
          return CartelProblema('Check your inbox',
              'A password reset email has been send to your address.');
        });

    Navigator.of(context).pop();
  }

  void createAccount(DtUsuario usuario, String password,
      void Function(Exception e) errorCallback, BuildContext context) async {
    try {
      if (DateTime.parse(usuario.fecha).isAfter(DateTime.now())) {
        errorCallback(Exception('Your birthdate must be in the past.'));
      } else {
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
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      errorCallback(e);
    }
  }

  void signOut() {
    _usuarioSubscription?.cancel();
    _tweetsSubscription?.cancel();
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentReference> publicarTweet(String message) {
    if (_usuario == null) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('tweets')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
