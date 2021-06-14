import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';

import 'package:seritex/Views/totalentrega.dart';

class UltimaEntregaUsuario extends StatefulWidget {
  const UltimaEntregaUsuario({Key key}) : super(key: key);

  @override
  _UltimaEntregaUsuarioState createState() => _UltimaEntregaUsuarioState();
}

class _UltimaEntregaUsuarioState extends State<UltimaEntregaUsuario> {
  enviaData(String dados) {
    var rota = new MaterialPageRoute(
        builder: (BuildContext context) => TotalEntregaUsuario(
              data: dados,
            ));
    Navigator.of(context).push(rota);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ultimas Entregas'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(uidLogado.uid)
              .collection('entregas')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }
            var dados = snapshot.data.docs;
            return Container(
              child: ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () => enviaData(dados[index]['dataFinal']),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              DateFormat("'Entrega Dia:' dd/MM/yyyy").format(
                                DateFormat('yyyy-MM-dd').parse(
                                  dados[index]['dataFinal'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            );
          }),
    );
  }
}
