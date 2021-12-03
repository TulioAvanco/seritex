import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/addEntrega.controller.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/entrega.model.dart';

class NovaEntrega extends StatefulWidget {
  @override
  _NovaEntregaState createState() => _NovaEntregaState();
}

class _NovaEntregaState extends State<NovaEntrega> {
  final _formKey4 = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  DateTime dataSelect = DateTime.now();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  Entrega novaEntrega = new Entrega();

  DateTime dataFinal = DateTime(2015);

  lancar(BuildContext context) {
    _formKey4.currentState.save();
    if (_formKey4.currentState.validate()) {
      AddEntrega().addEntrega(this.novaEntrega);
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Entrega adicionada',
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
  }

  @override
  void initState() {
    novaEntrega.dataFinal = formatter.format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nova Entrega'),
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

                var dados = snapshot.data.docs;

                var i = 1;
                String pegaData;
                while (i < dados.length) {
                  pegaData = dados[i]['dataInicio'].toString();
                  i++;
                }
                dataFinal = DateFormat('yyyy-MM-dd').parse(pegaData);

                return Center(
                    child: Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      StatefulBuilder(builder: (context, setState) {
                        return Column(children: [
                          Text('Data',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 118, 70),
                                  fontSize: 22)),
                          Padding(padding: EdgeInsets.only(bottom: 16)),
                          Text(
                              DateFormat("dd/MM/yyyy")
                                  .format(DateFormat('dd-MM-yyyy').parse(
                                novaEntrega.dataFinal,
                              )),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 118, 70),
                                  fontSize: 22)),
                          Padding(padding: EdgeInsets.only(bottom: 16)),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                height: 59, width: double.infinity),
                            child: ElevatedButton(
                              onPressed: () async {
                                final DateTime pickedDate =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: this.dataSelect,
                                        firstDate: dataFinal,
                                        lastDate: currentDate);
                                if (pickedDate != null &&
                                    pickedDate != currentDate)
                                  setState(() {
                                    novaEntrega.dataFinal =
                                        formatter.format(pickedDate);
                                    this.dataSelect = pickedDate;
                                    print(dataFinal);
                                  });
                              },
                              child: Text('Alterar Data',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white)),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 25, 118, 70)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(18))),
                            ),
                          )
                        ]);
                      }),
                      Form(
                          key: _formKey4,
                          child: Container(
                            child: Column(children: [
                              Padding(padding: EdgeInsets.only(top: 20)),
                              TextFormField(
                                cursorColor: Color.fromARGB(255, 25, 118, 70),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.archive,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    ),
                                    labelStyle: (TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70))),
                                    labelText: 'Quilos',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)))),
                                onSaved: (value) => this.novaEntrega.kilos =
                                    double.parse(value),
                                validator: (value) =>
                                    value.isEmpty ? "Campo Obrigatório" : null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              TextFormField(
                                cursorColor: Color.fromARGB(255, 25, 118, 70),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.monetization_on,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    ),
                                    labelStyle: (TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70))),
                                    labelText: 'Preço',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)))),
                                onSaved: (value) => this.novaEntrega.preco =
                                    double.parse(value),
                                validator: (value) =>
                                    value.isEmpty ? "Campo Obrigatório" : null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              TextFormField(
                                cursorColor: Color.fromARGB(255, 25, 118, 70),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.inbox,
                                      color: Color.fromARGB(255, 25, 118, 70),
                                    ),
                                    labelStyle: (TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70))),
                                    labelText: 'Caixas',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 25, 118, 70)))),
                                onSaved: (value) =>
                                    this.novaEntrega.caixas = int.parse(value),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 59, width: double.infinity),
                                child: ElevatedButton(
                                  onPressed: () => lancar(context),
                                  child: Text('Lançar',
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
                            ]),
                          )),
                    ],
                  ),
                ));
              }),
        ));
  }
}
