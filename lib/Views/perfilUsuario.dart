import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/usuario.model.dart';

class PerfilUsuario extends StatefulWidget {
  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  editaPerfil(BuildContext context) {
    _formKey5.currentState.save();
    if (_formKey5.currentState.validate()) {
      CadastroController().editaUser(_novoUser);
      Navigator.of(context).pop();
    }
  }

  final _formKey5 = GlobalKey<FormState>();
  final _novoUser = new Usuario();
  bool editar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('usuarios')
                .doc(uidLogado.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 25, 118, 70),
                    ),
                  ),
                );
              }
              if (snapshot == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 25, 118, 70),
                    ),
                  ),
                );
              }
              var dados = snapshot.data;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        height: 200,
                        color: Color.fromARGB(255, 25, 118, 70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 8)),
                            CircleAvatar(
                              radius: 50,
                              child: Image.asset(
                                'assets/images/SeriTex_icon.png',
                                fit: BoxFit.fill,
                                height: 100,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 8)),
                            Text(dados['nome'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            Padding(padding: EdgeInsets.only(bottom: 8)),
                          ],
                        ),
                      )),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  Container(
                      margin: EdgeInsets.all(60),
                      child: Form(
                        key: _formKey5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              initialValue: dados['nome'],
                              cursorColor: Color.fromARGB(255, 25, 118, 70),
                              decoration: InputDecoration(
                                  labelStyle: (TextStyle(
                                      color: Color.fromARGB(255, 25, 118, 70))),
                                  icon: Icon(Icons.account_circle_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70)),
                                  labelText: 'Nome',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70)))),
                              onSaved: (value) => _novoUser.nome = value,
                              validator: (value) =>
                                  value.isEmpty ? "Campo Obrigatório" : null,
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            TextFormField(
                              initialValue: dados['email'],
                              enabled: false,
                              cursorColor: Color.fromARGB(255, 25, 118, 70),
                              decoration: InputDecoration(
                                  labelStyle: (TextStyle(
                                      color: Color.fromARGB(255, 25, 118, 70))),
                                  icon: Icon(Icons.mail_outline_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70)),
                                  labelText: 'E-mail',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70)))),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            TextFormField(
                              initialValue: dados['telefone'],
                              keyboardType: TextInputType.number,
                              cursorColor: Color.fromARGB(255, 25, 118, 70),
                              decoration: InputDecoration(
                                  labelStyle: (TextStyle(
                                      color: Color.fromARGB(255, 25, 118, 70))),
                                  icon: Icon(Icons.phone_android_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70)),
                                  labelText: 'Telefone',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70)))),
                              onSaved: (value) => _novoUser.telefone = value,
                              validator: (value) =>
                                  value.isEmpty ? "Campo Obrigatório" : null,
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            ElevatedButton(
                              onPressed: () => editaPerfil(context),
                              child: Text('Salvar',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white)),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 25, 118, 70)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(16))),
                            )
                          ],
                        ),
                      ))
                ],
              );
            }),
      ),
    );
  }
}
