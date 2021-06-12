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
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  Corte adiciona = new Corte();
  int tabela;

  List<Corte> listaCorte = [];
  Corte novoCorte = new Corte();

  @override
  void initState() {
    novoCorte.data = formatter.format(DateTime.now());
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        novoCorte.data = formatter.format(pickedDate);
      });
  }

  Future<String> buscaTabelas() async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .where('uid', isEqualTo: uidLogado.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.tabela = int.parse(doc['tabela']);
      });
    });

    return 'ok';
  }

  setSelectedUser(int corte) {
    setState(() {
      novoCorte.valor = corte;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> radio = [];
    for (int x = 1; x <= this.tabela; x++) {
      Corte adiciona = new Corte();
      adiciona.valor = x;
      adiciona.texto = 'Tabela ' + x.toString();
      radio.add(RadioListTile(
        title: Text(adiciona.texto),
        value: adiciona.valor,
        groupValue: novoCorte.valor,
        activeColor: Color.fromARGB(255, 25, 118, 70),
        onChanged: (valor) {
          setSelectedUser(valor);
        },
      ));
    }
    return radio;
  }

  buildContainer() {
    return FutureBuilder(
      future: buscaTabelas(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 32)),
                        Text('Data',
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 118, 70),
                                fontSize: 22)),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        Text(novoCorte.data,
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 118, 70),
                                fontSize: 22)),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              'Alterar Data',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 25, 118, 70)))),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 32)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2, color: Color.fromARGB(255, 25, 118, 70))),
                    width: 300,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: createRadioListUsers(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 32)),
                  ElevatedButton(
                    onPressed: () => addCorte(context),
                    child: Text('Cadastrar',
                        style: TextStyle(fontSize: 23, color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 25, 118, 70)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(18))),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 25, 118, 70),
            ),
          );
        }
      },
    );
  }

  addCorte(BuildContext context) {
    AddCorteController().addCorte(novoCorte);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Corte'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 25, 118, 70),
        ),
        body: buildContainer());
  }
}
