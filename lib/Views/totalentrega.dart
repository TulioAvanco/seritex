import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Views/mostraEntregaUsuario.dart';

class TotalEntregaUsuario extends StatefulWidget {
  final String data;

  TotalEntregaUsuario({this.data});
  @override
  _TotalEntregaUsuarioState createState() => _TotalEntregaUsuarioState();
}

class _TotalEntregaUsuarioState extends State<TotalEntregaUsuario> {
  enviaDados(String uidSangrador, String dataFinal, String dataInicio) {
    var rota = new MaterialPageRoute(
        builder: (BuildContext context) => MostraEntregaUsuario(
              uidSangrador: uidSangrador,
              dataFinal: dataFinal,
              dataInicio: dataInicio,
            ));
    Navigator.of(context).push(rota);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrega dia ' +
            DateFormat("dd/MM/yyyy").format(DateFormat('yyyy-MM-dd').parse(
              widget.data,
            ))),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(uidLogado.uid)
              .collection('entregas')
              .doc(widget.data)
              .collection('peloSangrador')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }
            double kilos = 0;
            double valor = 0;
            String dataInicio;
            var dados = snapshot.data.docs;
            for (var x in dados) {
              valor = x['preco'];
              kilos = kilos + double.parse(x['kilos'].toString());
              dataInicio = x['dataInicio'];
            }

            return Column(children: [
              Padding(padding: EdgeInsets.only(top: 26)),
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
                                  widget.data,
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
                            padding: const EdgeInsets.all(30.0),
                            child: Text(double.parse(kilos.toString())
                                .toStringAsFixed(2)),
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
                            padding: const EdgeInsets.all(30.0),
                            child: Text('R\$' + valor.toString()),
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
              Padding(padding: EdgeInsets.only(bottom: 26)),
              SizedBox(
                height: 300,
                child: ListView(children: [
                  for (var x in dados)
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('sangradores')
                            .doc(x['uidSangrador'])
                            .snapshots(),
                        builder: (BuildContext context, snapshot2) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          var dados2 = snapshot2.data;
                          return Container(
                            child: Card(
                                elevation: 5,
                                child: InkWell(
                                  onTap: () => enviaDados(
                                    dados2['uid'].toString(),
                                    widget.data,
                                    dataInicio,
                                  ),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(dados2['nome']),
                                    ),
                                  ),
                                )),
                          );
                        })
                ]),
              )
            ]);
          }),
    );
  }
}
