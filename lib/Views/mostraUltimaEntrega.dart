import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';

class MostraEntrega extends StatefulWidget {
  final String entrega;

  MostraEntrega({this.entrega});

  @override
  _MostraEntregaState createState() => _MostraEntregaState();
}

class _MostraEntregaState extends State<MostraEntrega> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrega'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('sangradores')
              .doc(uidLogado.uid)
              .collection('entregas')
              .doc(widget.entrega)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            var dados = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                    .doc(uidLogado.uid)
                    .collection('entregas')
                    .doc(widget.entrega)
                    .collection('cortes')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  var dados2 = snapshot2.data.docs;
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 25, 118, 70),
                        ),
                      ),
                    );
                  }
                  if (dados2.isEmpty) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 25, 118, 70),
                        ),
                      ),
                    );
                  }
                  return ListView(children: [
                    Padding(padding: EdgeInsets.only(top: 28)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ultima Entrega',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 25, 118, 70)),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 32)),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Data',
                                style: TextStyle(fontSize: 18),
                              ),
                              Padding(padding: EdgeInsets.only(top: 16)),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
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
                                      color: Color.fromARGB(255, 25, 118, 70)),
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
                                'kilos',
                                style: TextStyle(fontSize: 18),
                              ),
                              Padding(padding: EdgeInsets.only(top: 16)),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(dados['kilos'].toString()),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3,
                                      color: Color.fromARGB(255, 25, 118, 70)),
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
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(dados['preco'].toString()),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3,
                                      color: Color.fromARGB(255, 25, 118, 70)),
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
                          'Cortes',
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
                        itemCount: dados2.length - 1,
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
                                        dados2[index]['tabela'].toString(),
                                  ),
                                ),
                              ));
                        },
                      ),
                    )
                  ]);
                });
          }),
    );
  }
}
