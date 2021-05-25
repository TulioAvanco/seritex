import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seritex/Models/usuario.model.dart';

class CadastroController {
  void addUser(Usuario user) {
    FirebaseFirestore.instance.collection('usuarios').add({
      'login': user.login,
      'senha': user.senha,
      'nome': user.nome,
      'email': user.email,
      'telefone': user.telefone,
      'status': user.status,
    });
  }
}
