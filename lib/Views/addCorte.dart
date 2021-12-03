import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/addCorte.controller.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/corte.model.dart';

class AddCorte extends StatefulWidget {
  @override
  _AddCorteState createState() => _AddCorteState();
}

class _AddCorteState extends State<AddCorte> {
  DateTime currentDate = DateTime.now();

  Corte adiciona = new Corte();

  List<Corte> listaCorte = [];
  Corte novoCorte = new Corte();
  DateTime dataFinal = DateTime(2015);

  @override
  void initState() {
    novoCorte.data = DateTime.now().toString();
    super.initState();
  }

  addCorte(BuildContext context) {
    AddCorteController().addCorte(novoCorte);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Corte Lançado',
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 1500),
      width: 280.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Color.fromARGB(255, 25, 118, 70),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Corte'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 25, 118, 70),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('sangradores')
                  .doc(uidLogado.uid)
                  .collection('entregas')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sangradores')
                        .doc(uidLogado.uid)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot1) {
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 25, 118, 70),
                            ),
                          ),
                        );
                      }
                      if (!snapshot1.hasData) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 25, 118, 70),
                            ),
                          ),
                        );
                      }
                      var dados = snapshot.data.docs;
                      var i = 1;
                      var dados2 = snapshot1.data;
                      int tabelas = int.parse(dados2['tabela']);
                      List<Widget> radio = [];
                      for (int x = 1; x <= tabelas; x++) {
                        Corte adiciona = new Corte();
                        adiciona.valor = x;
                        adiciona.texto = 'Tabela ' + x.toString();
                        radio.add(RadioListTile(
                          title: Text(adiciona.texto),
                          value: adiciona.valor,
                          groupValue: novoCorte.valor,
                          activeColor: Color.fromARGB(255, 25, 118, 70),
                          onChanged: (valor) {
                            setState(() {
                              novoCorte.valor = valor;
                            });
                          },
                        ));
                      }

                      String pegaData;
                      while (i < dados.length) {
                        pegaData = dados[i]['dataInicio'].toString();
                        i++;
                      }
                      dataFinal = DateFormat('yyyy-MM-dd').parse(pegaData);
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 50, right: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 32)),
                                    Text('Data',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70),
                                            fontSize: 22)),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 16)),
                                    Text(
                                        DateFormat("dd/MM/yyyy").format(
                                            DateFormat('yyyy-MM-dd').parse(
                                          novoCorte.data,
                                        )),
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70),
                                            fontSize: 22)),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 16)),
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          height: 59, width: double.infinity),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final DateTime pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateFormat(
                                                          'yyyy-MM-dd')
                                                      .parse(novoCorte.data),
                                                  firstDate: dataFinal,
                                                  lastDate: currentDate);
                                          if (pickedDate != null &&
                                              pickedDate != currentDate)
                                            setState(() {
                                              novoCorte.data =
                                                  pickedDate.toString();

                                              print(dataFinal);
                                            });
                                        },
                                        child: Text('Alterar Data',
                                            style: TextStyle(
                                                fontSize: 23,
                                                color: Colors.white)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 25, 118, 70)),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.all(18))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 32)),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 25, 118, 70))),
                                  width: 300,
                                  alignment: Alignment.center,
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [for (var x in radio) x]);
                                  })),
                              Padding(padding: EdgeInsets.only(bottom: 32)),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 59, width: double.infinity),
                                child: ElevatedButton(
                                  onPressed: () => addCorte(context),
                                  child: Text('Cadastrar',
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.white)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(255, 25, 118, 70)),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(18))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ));
  }
}
