import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Models/sangrador.model.dart';
import 'package:seritex/Models/usuario.model.dart';

User uidLogado;
String verifica;

class CadastroController {
  User pess = FirebaseAuth.instance.currentUser;

  void addUser(Usuario user) {
    FirebaseFirestore.instance.collection('usuarios').doc(pess.uid).set({
      'senha': user.senha,
      'nome': user.nome,
      'email': user.email,
      'telefone': user.telefone,
      'status': user.status,
      'uid': pess.uid
    });
  }

  void addSangrador(Sangrador user) {
    FirebaseFirestore.instance.collection('sangradores').doc(pess.uid).set({
      'senha': user.senha,
      'nome': user.nome,
      'email': user.email,
      'telefone': user.telefone,
      'status': user.status,
      'uid': pess.uid,
      'uidProprietario': user.idProprietario,
      'tabela': user.tabelas
    });
  }

  signIn(Usuario login, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login.email, password: login.senha);
      User uidLogado = FirebaseAuth.instance.currentUser;

      FirebaseFirestore.instance
          .collection('usuarios')
          .where('uid', isEqualTo: uidLogado.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          verifica = (doc['uid']);
        });
        if (verifica == uidLogado.uid) {
          Navigator.popAndPushNamed(context, '/homeadm');
        } else {
          Navigator.popAndPushNamed(context, '/homeSangrador');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'E-mail não Cadastrado.',
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(milliseconds: 1500),
          width: 280.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Color.fromARGB(255, 25, 118, 70),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Senha Incorreta',
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(milliseconds: 1500),
          width: 280.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Color.fromARGB(255, 173, 46, 36),
        ));
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    uidLogado = null;
    print(uidLogado);
  }
}
