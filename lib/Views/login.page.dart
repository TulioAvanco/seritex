import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/usuario.model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _login = new Usuario();

  var _passwordobscure = true;
  String verifica;
  login(BuildContext context) {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      CadastroController().signIn(_login, context);
    }
  }

  Future<dynamic> cadastese(BuildContext context) async {
    await Navigator.of(context).pushNamed('/cadastro');
  }

  verificaLogin() async {
    uidLogado = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.verifica = (doc['uid']);
      });
    });
    if (this.verifica == FirebaseAuth.instance.currentUser.uid) {
      Navigator.popAndPushNamed(context, '/homeadm');
    } else {
      Navigator.popAndPushNamed(context, '/homeSangrador');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('usuarios').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                if (FirebaseAuth.instance.currentUser != null &&
                    snapshot != null) {
                  verificaLogin();
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 25, 118, 70),
                      ),
                    ),
                  );
                }

                return Container(
                  height: 700,
                  margin: EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset('assets/images/SeriTex_logo.png'),
                        height: 250,
                      ),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                cursorColor: Color.fromARGB(255, 25, 118, 70),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.person,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    ),
                                    labelStyle: (TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70))),
                                    labelText: 'E-mail',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)))),
                                onSaved: (value) => _login.email = value,
                                validator: (value) =>
                                    value.isEmpty ? "Campo Obrigatório" : null,
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 16)),
                              StatefulBuilder(builder: (context, setState) {
                                return TextFormField(
                                  obscureText: _passwordobscure,
                                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordobscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color:
                                              Color.fromARGB(255, 25, 118, 70),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordobscure =
                                                !_passwordobscure;
                                          });
                                        },
                                      ),
                                      labelText: 'Senha',
                                      labelStyle: (TextStyle(
                                          color: Color.fromARGB(
                                              255, 25, 118, 70))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 25, 118, 70))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 25, 118, 70)))),
                                  onSaved: (value) => _login.senha = value,
                                  validator: (value) => value.isEmpty
                                      ? "Campo Obrigatório"
                                      : null,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: 59, width: double.infinity),
                              child: ElevatedButton(
                                onPressed: () => login(context),
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 23),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 25, 118, 70)),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: 59, width: double.infinity),
                              child: ElevatedButton(
                                onPressed: () => cadastese(context),
                                child: Text(
                                  'Cadastre-se',
                                  style: TextStyle(fontSize: 23),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 1, 41, 95))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
