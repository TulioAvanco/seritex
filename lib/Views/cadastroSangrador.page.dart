import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/sangrador.model.dart';

class CadastroSangrador extends StatefulWidget {
  @override
  _CadastroSangradorState createState() => _CadastroSangradorState();
}

class _CadastroSangradorState extends State<CadastroSangrador> {
  final _formKey3 = GlobalKey<FormState>();
  var _passwordobscure = true;
  final _sangrador = Sangrador();

  cadastrese(BuildContext context) async {
    _formKey3.currentState.save();
    User pess = FirebaseAuth.instance.currentUser;
    _sangrador.idProprietario = pess.uid;
    if (_formKey3.currentState.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _sangrador.email, password: _sangrador.senha);
        CadastroController().addSangrador(_sangrador);
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
          title: Text('Novo Sangrador'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 25, 118, 70),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(60),
              child: Form(
                key: _formKey3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          icon: Icon(Icons.account_circle_rounded,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Nome',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _sangrador.nome = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          icon: Icon(Icons.mail,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _sangrador.email = value,
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
                          icon: Icon(Icons.lock,
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
                      onSaved: (value) => _sangrador.senha = value,
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
                          icon: Icon(Icons.lock,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Confirmar Senha',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => confirmaSenha = value,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      decoration: InputDecoration(
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          icon: Icon(Icons.phone,
                              color: Color.fromARGB(255, 25, 118, 70)),
                          labelText: 'Telefone',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) => _sangrador.telefone = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    Text(
                      'Numero de Tabelas',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                    DropdownButton<String>(
                      value: _sangrador.tabelas,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Color.fromARGB(255, 25, 118, 70),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 25, 118, 70)),
                      underline: Container(
                        height: 2,
                        color: Color.fromARGB(255, 25, 118, 70),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _sangrador.tabelas = newValue;
                        });
                      },
                      items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    ElevatedButton(
                      onPressed: () => cadastrese(context),
                      child: Text('Cadastrar',
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 25, 118, 70)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(18))),
                    ),
                  ],
                ),
              )),
        ));
  }
}
