import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Models/propriedade.model.dart';
import 'package:seritex/Models/sangrador.model.dart';
import 'package:seritex/Models/usuario.model.dart';

User uidLogado;
String verifica;

class CadastroController {
  User pess = FirebaseAuth.instance.currentUser;

  void addUser(Usuario user, Propridade propridade) async {
    await FirebaseFirestore.instance.collection('usuarios').doc(pess.uid).set({
      'nome': user.nome,
      'email': user.email,
      'telefone': user.telefone,
      'status': user.status,
      'uid': pess.uid,
      'imagem':
          'https://firebasestorage.googleapis.com/v0/b/api-seritex.appspot.com/o/SeriTex_icon.png?alt=media&token=34405a61-e9b5-4e4f-a277-98c687412250'
    });
    await FirebaseFirestore.instance
        .collection('propriedades')
        .doc(pess.uid)
        .set({
      'propriedade': propridade.propriedade,
      'qtdAlqueires': propridade.qtdAlqueires,
      'qtdArvores': propridade.qtdtArvores,
      'uid': pess.uid,
      'imagem':
          'https://firebasestorage.googleapis.com/v0/b/api-seritex.appspot.com/o/SeriTex_icon.png?alt=media&token=34405a61-e9b5-4e4f-a277-98c687412250'
    });
  }

  void editaUser(Usuario user) async {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uidLogado.uid)
        .update({
      'nome': user.nome,
      'telefone': user.telefone,
    });
  }

  void editaPropriedade(Propridade prop) async {
    await FirebaseFirestore.instance
        .collection('propriedades')
        .doc(uidLogado.uid)
        .update({
      'propriedade': prop.propriedade,
      'qtdAlqueires': prop.qtdAlqueires,
      'qtdArvores': prop.qtdtArvores,
    });
  }

  void editaSangrador(Sangrador user) async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .update({
      'nome': user.nome,
      'telefone': user.telefone,
    });
  }

  void addSangrador(Sangrador user) {
    FirebaseFirestore.instance.collection('sangradores').doc(pess.uid).set({
      'nome': user.nome,
      'email': user.email,
      'telefone': user.telefone,
      'status': user.status,
      'uid': pess.uid,
      'uidProprietario': uidLogado.uid,
      'percentual': user.percentual,
      'tabela': user.tabelas,
      'imagem':
          'https://firebasestorage.googleapis.com/v0/b/api-seritex.appspot.com/o/SeriTex_icon.png?alt=media&token=34405a61-e9b5-4e4f-a277-98c687412250'
    });
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uidLogado.uid)
        .collection('sangradores')
        .doc(pess.uid)
        .set({'uidSangrador': pess.uid});
  }

  void editaSangradorAdm(Sangrador sangra) async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(sangra.idUser)
        .update({
      'percentual': sangra.percentual,
      'tabela': sangra.tabelas,
    });
  }

  signIn(Usuario login, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login.email, password: login.senha);
      FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
      uidLogado = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('usuarios')
          .where('uid', isEqualTo: uidLogado.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
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
    await FirebaseFirestore.instance.clearPersistence();
  }
}
