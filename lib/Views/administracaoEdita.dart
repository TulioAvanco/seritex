import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/sangrador.model.dart';

class AdministracaoEdita extends StatefulWidget {
  final String uidSangrador;

  AdministracaoEdita({this.uidSangrador});

  @override
  _AdministracaoEditaState createState() => _AdministracaoEditaState();
}

class _AdministracaoEditaState extends State<AdministracaoEdita> {
  final _formKey7 = GlobalKey<FormState>();
  final _sangrador = new Sangrador();
  editaPerfil(BuildContext context) {
    _formKey7.currentState.save();
    if (_formKey7.currentState.validate()) {
      CadastroController().editaSangradorAdm(_sangrador);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Sangrador'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('sangradores')
                .doc(widget.uidSangrador)
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
              _sangrador.percentual =
                  double.parse(dados['percentual'].toString());
              _sangrador.tabelas = dados['tabela'].toString();
              _sangrador.idUser = dados['uid'].toString();
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
                              backgroundImage: NetworkImage(dados['imagem']),
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
                        key: _formKey7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              initialValue: dados['nome'],
                              enabled: false,
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
                              initialValue: dados['telefone'].toString(),
                              enabled: false,
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
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            Text(
                              'Percentual de Divisão',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 25, 118, 70)),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            StatefulBuilder(builder: (context, setState) {
                              return Column(
                                children: [
                                  Slider(
                                      value: _sangrador.percentual,
                                      max: 100,
                                      min: 1,
                                      divisions: 100,
                                      label: _sangrador.percentual
                                          .round()
                                          .toString(),
                                      activeColor:
                                          Color.fromARGB(255, 25, 118, 70),
                                      onChanged: (double value) => {
                                            setState(() {
                                              _sangrador.percentual =
                                                  value.round().toDouble();
                                            })
                                          }),
                                  Text(
                                    _sangrador.percentual.round().toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 25, 118, 70)),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 16)),
                                  Text(
                                    'Numero de Tabelas',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 25, 118, 70)),
                                  ),
                                  DropdownButton<String>(
                                    value: _sangrador.tabelas,
                                    icon: const Icon(
                                      Icons.arrow_downward_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70)),
                                    underline: Container(
                                      height: 2,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _sangrador.tabelas = newValue;
                                      });
                                    },
                                    items: [
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6',
                                      '7',
                                      '8',
                                      '9',
                                      '10'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            }),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: 59, width: double.infinity),
                              child: ElevatedButton(
                                onPressed: () => editaPerfil(context),
                                child: Text('Salvar',
                                    style: TextStyle(
                                        fontSize: 23, color: Colors.white)),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 25, 118, 70)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(16))),
                              ),
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
