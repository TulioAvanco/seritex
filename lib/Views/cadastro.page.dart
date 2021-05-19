import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey2 = GlobalKey<FormState>();
  var _passwordobscure = true;

  cadastrese() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: Container(
          margin: EdgeInsets.all(60),
          child: Form(
            key: _formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: true,
                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 25, 118, 70),
                      ),
                      labelStyle:
                          (TextStyle(color: Color.fromARGB(255, 25, 118, 70))),
                      labelText: 'Login',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70)))),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                TextFormField(
                  obscureText: _passwordobscure,
                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                  decoration: InputDecoration(
                      labelStyle:
                          (TextStyle(color: Color.fromARGB(255, 25, 118, 70))),
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
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                TextFormField(
                  obscureText: true,
                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                  decoration: InputDecoration(
                      labelStyle:
                          (TextStyle(color: Color.fromARGB(255, 25, 118, 70))),
                      icon: Icon(Icons.lock,
                          color: Color.fromARGB(255, 25, 118, 70)),
                      labelText: 'Confirmar Senha',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70)))),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                TextFormField(
                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                  decoration: InputDecoration(
                      labelStyle:
                          (TextStyle(color: Color.fromARGB(255, 25, 118, 70))),
                      icon: Icon(Icons.account_circle_rounded,
                          color: Color.fromARGB(255, 25, 118, 70)),
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70)))),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                TextFormField(
                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                  decoration: InputDecoration(
                      labelStyle:
                          (TextStyle(color: Color.fromARGB(255, 25, 118, 70))),
                      icon: Icon(Icons.mail,
                          color: Color.fromARGB(255, 25, 118, 70)),
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70)))),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                TextFormField(
                  cursorColor: Color.fromARGB(255, 25, 118, 70),
                  decoration: InputDecoration(
                      labelStyle:
                          (TextStyle(color: Color.fromARGB(255, 25, 118, 70))),
                      icon: Icon(Icons.phone,
                          color: Color.fromARGB(255, 25, 118, 70)),
                      labelText: 'Telefone',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 25, 118, 70)))),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                ElevatedButton(
                  onPressed: () => cadastrese(),
                  child: Text('Cadastrar',
                      style: TextStyle(fontSize: 23, color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 25, 118, 70)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(16))),
                ),
              ],
            ),
          )),
    );
  }
}
