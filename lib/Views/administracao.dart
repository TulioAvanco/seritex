import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/propriedade.model.dart';
import 'package:seritex/Views/administracaoEdita.dart';

class Administracao extends StatefulWidget {
  @override
  _AdministracaoState createState() => _AdministracaoState();
}

class _AdministracaoState extends State<Administracao> {
  editaPerfil(BuildContext context) {
    _formKey6.currentState.save();
    if (_formKey6.currentState.validate()) {
      CadastroController().editaPropriedade(_propriedade);
      Navigator.of(context).pop();
    }
  }

  final _formKey6 = GlobalKey<FormState>();
  final _propriedade = new Propridade();

  enviaSangrador(String uid) {
    var rota = new MaterialPageRoute(
        builder: (BuildContext context) => AdministracaoEdita(
              uidSangrador: uid,
            ));
    Navigator.of(context).push(rota);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adminstração'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('propriedades')
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

              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('sangradores')
                      .where('uidProprietario', isEqualTo: uidLogado.uid)
                      .where('status', isEqualTo: 0)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 25, 118, 70),
                          ),
                        ),
                      );
                    }
                    if (snapshot2 == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 25, 118, 70),
                          ),
                        ),
                      );
                    }
                    var dados = snapshot.data;
                    var dados2 = snapshot2.data.docs;
                    return Column(
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        Container(
                            margin: EdgeInsets.all(60),
                            child: Form(
                              key: _formKey6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    initialValue: dados['propriedade'],
                                    cursorColor:
                                        Color.fromARGB(255, 25, 118, 70),
                                    decoration: InputDecoration(
                                        labelStyle: (TextStyle(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                        icon: Icon(Icons.home_outlined,
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)),
                                        labelText: 'Propriedade',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 25, 118, 70))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 25, 118, 70)))),
                                    onSaved: (value) =>
                                        _propriedade.propriedade = value,
                                    validator: (value) => value.isEmpty
                                        ? "Campo Obrigatório"
                                        : null,
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 16)),
                                  TextFormField(
                                    initialValue:
                                        dados['qtdAlqueires'].toString(),
                                    keyboardType: TextInputType.number,
                                    cursorColor:
                                        Color.fromARGB(255, 25, 118, 70),
                                    decoration: InputDecoration(
                                        labelStyle: (TextStyle(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                        icon: Icon(Icons.texture_outlined,
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)),
                                        labelText: 'Alqueires',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 25, 118, 70))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 25, 118, 70)))),
                                    onSaved: (value) => _propriedade
                                        .qtdAlqueires = int.parse(value),
                                    validator: (value) => value.isEmpty
                                        ? "Campo Obrigatório"
                                        : null,
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 16)),
                                  TextFormField(
                                    initialValue:
                                        dados['qtdArvores'].toString(),
                                    keyboardType: TextInputType.number,
                                    cursorColor:
                                        Color.fromARGB(255, 25, 118, 70),
                                    decoration: InputDecoration(
                                        labelStyle: (TextStyle(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                        icon: Icon(Icons.park_outlined,
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)),
                                        labelText: 'Arvores',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 25, 118, 70))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 25, 118, 70)))),
                                    onSaved: (value) => _propriedade
                                        .qtdtArvores = int.parse(value),
                                    validator: (value) => value.isEmpty
                                        ? "Campo Obrigatório"
                                        : null,
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 16)),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tightFor(
                                        height: 59, width: double.infinity),
                                    child: ElevatedButton(
                                      onPressed: () => editaPerfil(context),
                                      child: Text('Salvar',
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white)),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 25, 118, 70)),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(16))),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        Text(
                          'Sangradores: ' + dados2.length.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70),
                              fontSize: 16),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                              itemCount: dados2.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 5,
                                    child: InkWell(
                                      onTap: () => enviaSangrador(
                                          dados2[index]['uid'].toString()),
                                      child: ListTile(
                                        title: Center(
                                          child: Text(dados2[index]['nome']),
                                        ),
                                      ),
                                    ));
                              }),
                        )
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
