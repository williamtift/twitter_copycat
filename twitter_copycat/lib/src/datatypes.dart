class DtUsuario {
  DtUsuario(this.uid, this.name, this.email, this.fecha);

  String uid;
  String name;
  String email;
  String fecha;

}

class Tweet {
  Tweet({required this.name, required this.message});
  final String name;
  final String message;
}