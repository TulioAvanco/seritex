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

  login(BuildContext context) {
    _formKey.currentState.save();
    CadastroController().signIn(_login, context);
  }

  Future<dynamic> cadastese(BuildContext context) async {
    await Navigator.of(context).pushNamed('/cadastro');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(30),
                child: Image.asset('assets/images/SeriTex_logo.png')),
            Form(
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
                            color: Color.fromARGB(255, 25, 118, 70))),
                        labelText: 'E-mail',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 118, 70))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 118, 70)))),
                    onSaved: (value) => _login.email = value,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  TextFormField(
                    obscureText: _passwordobscure,
                    cursorColor: Color.fromARGB(255, 25, 118, 70),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordobscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromARGB(255, 25, 118, 70),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordobscure = !_passwordobscure;
                            });
                          },
                        ),
                        labelText: 'Senha',
                        labelStyle: (TextStyle(
                            color: Color.fromARGB(255, 25, 118, 70))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 118, 70))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 118, 70)))),
                    onSaved: (value) => _login.senha = value,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  ElevatedButton(
                    onPressed: () => login(context),
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 23),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 25, 118, 70)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(8))),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  ElevatedButton(
                    onPressed: () => cadastese(context),
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(fontSize: 23),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(8),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 1, 41, 95))),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
