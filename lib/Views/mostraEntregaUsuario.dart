import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';

class MostraEntregaUsuario extends StatefulWidget {
  final String uidSangrador;
  final String dataFinal;
  final String dataInicio;

  MostraEntregaUsuario({this.uidSangrador, this.dataFinal, this.dataInicio});

  @override
  _MostraEntregaUsuarioState createState() => _MostraEntregaUsuarioState();
}

class _MostraEntregaUsuarioState extends State<MostraEntregaUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrega' +
            DateFormat("dd/MM/yyyy").format(DateFormat('yyyy-MM-dd').parse(
              widget.dataFinal,
            ))),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(uidLogado.uid)
              .collection('entregas')
              .doc(widget.dataFinal)
              .collection('peloSangrador')
              .doc(widget.uidSangrador)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
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
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('sangradores')
                    .doc(widget.uidSangrador)
                    .collection('entregas')
                    .doc(widget.dataInicio)
                    .collection('cortes')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 25, 118, 70),
                        ),
                      ),
                    );
                  }

                  if (!snapshot2.hasData) {
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
                          .doc(widget.uidSangrador)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot3) {
                        if (snapshot3.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 25, 118, 70),
                              ),
                            ),
                          );
                        }
                        if (!snapshot3.hasData) {
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
                        var dados3 = snapshot3.data;

                        return ListView(children: [
                          Padding(padding: EdgeInsets.only(top: 28)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Relatório de ' + dados3['nome'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 25, 118, 70)),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 32)),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Data',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 16)),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Text(
                                          DateFormat("dd/MM/yyyy").format(
                                            DateFormat('yyyy-MM-dd').parse(
                                              dados['dataFinal'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 16)),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Quilos',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 16)),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Text(double.parse(
                                                dados['kilos'].toString())
                                            .toStringAsFixed(2)),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 16)),
                                    Icon(
                                      Icons.monitor_weight_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Preço',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 16)),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Text(
                                            'R\$' + dados['preco'].toString()),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 16)),
                                    Icon(
                                      Icons.price_change_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 28)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cortes: ' + dados2.length.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 25, 118, 70)),
                              )
                            ],
                          ),
                          Container(
                            width: 500,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: dados2.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Center(
                                        child: Text(
                                          DateFormat("'Corte Dia:' dd/MM/yyyy")
                                              .format(
                                            DateFormat('yyyy-MM-dd').parse(
                                              dados2[index]['data'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      subtitle: Center(
                                        child: Text(
                                          'Tabela ' +
                                              dados2[index]['tabela']
                                                  .toString(),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        ]);
                      });
                });
          }),
    );
  }
}
