import 'package:flutter/material.dart';
import 'src/logica.dart';
import 'src/logica.dart';
import 'src/colores.dart';
import 'src/screens/initial_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: colorImagenPrueba,
      )),
      home: Consumer<ApplicationState>(
        builder: (context, appState, _) => InitialScreen(
          createAccount: appState.createAccount,
        ),
      ),
    );
  }
}
