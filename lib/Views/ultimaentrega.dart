import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Views/mostraUltimaEntrega.dart';

class UltimaEntrega extends StatefulWidget {
  const UltimaEntrega({Key key}) : super(key: key);

  @override
  _UltimaEntregaState createState() => _UltimaEntregaState();
}

class _UltimaEntregaState extends State<UltimaEntrega> {
  enviaEntrega(String dados) {
    var rota = new MaterialPageRoute(
        builder: (BuildContext context) => MostraEntrega(
              entrega: dados,
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
              .collection('sangradores')
              .doc(uidLogado.uid)
              .collection('entregas')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
            var dados = snapshot.data.docs;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }
            if (dados.isEmpty) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }

            return Container(
              child: ListView.builder(
                itemCount: dados.length - 1,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () => enviaEntrega(dados[index]['dataInicio']),
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
