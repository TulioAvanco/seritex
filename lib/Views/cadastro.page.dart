import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/propriedade.model.dart';
import 'package:seritex/Models/usuario.model.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey2 = GlobalKey<FormState>();
  var _passwordobscure = true;
  final _novoUser = new Usuario();
  final _novaPropriedade = new Propridade();
  cadastrese(BuildContext context) async {
    _formKey2.currentState.save();
    if (_formKey2.currentState.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _novoUser.email, password: _novoUser.senha);
        CadastroController().addUser(_novoUser, _novaPropriedade);
        Navigator.of(context).pop(true);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'A senha fornecida é muito fraca.',
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
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'O e-mail já está em uso.',
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
        }
      } catch (e) {
        print(e);
      }
    }
  }

  String confirmaSenha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Cadastro'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 25, 118, 70),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(50),
              child: Form(
                key: _formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.account_box,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Nome',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _novoUser.nome = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.mail,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _novoUser.email = value,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Campo Obrigatório';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[.]+[a-z]")
                            .hasMatch(value)) {
                          return 'Preecha um E-mail Válido';
                        }
                        return null;
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      obscureText: _passwordobscure,
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.lock,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          suffixIcon: IconButton(
                            icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordobscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color.fromARGB(255, 25, 118, 70)),
                            onPressed: () {
                              setState(() {
                                _passwordobscure = !_passwordobscure;
                              });
                            },
                          ),
                          labelText: 'Senha',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _novoUser.senha = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      obscureText: true,
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.lock,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Confirmar Senha',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      validator: (value) => value != _novoUser.senha
                          ? "As senhas nao coincidem"
                          : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.phone_android,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Telefone',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _novoUser.telefone = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.cottage,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Nome da Propriedade',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _novaPropriedade.propriedade = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.fence,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Alqueires',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) =>
                          _novaPropriedade.qtdAlqueires = int.parse(value),
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          prefixIcon: Icon(Icons.park,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Quantidades de Árvores',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) =>
                          _novaPropriedade.qtdtArvores = int.parse(value),
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 59, width: double.infinity),
                      child: ElevatedButton(
                        onPressed: () => cadastrese(context),
                        child: Text('Cadastrar',
                            style:
                                TextStyle(fontSize: 23, color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 25, 118, 70)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16))),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
