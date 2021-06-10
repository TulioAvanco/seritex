import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/addEntrega.controller.dart';
import 'package:seritex/Models/entrega.model.dart';

class NovaEntrega extends StatefulWidget {
  const NovaEntrega({Key key}) : super(key: key);

  @override
  _NovaEntregaState createState() => _NovaEntregaState();
}

class _NovaEntregaState extends State<NovaEntrega> {
  final _formKey4 = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  Entrega novaEntrega = new Entrega();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        novaEntrega.dataFinal = formatter.format(pickedDate);
      });
  }

  lancar(BuildContext context) {
    _formKey4.currentState.save();
    if (_formKey4.currentState.validate()) {
      AddEntrega().addEntrega(this.novaEntrega);
      Navigator.pop(context);
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
        title: Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text('Data',
                style: TextStyle(
                    color: Color.fromARGB(255, 25, 118, 70), fontSize: 22)),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Text(novaEntrega.dataFinal,
                style: TextStyle(
                    color: Color.fromARGB(255, 25, 118, 70), fontSize: 22)),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Alterar Data',
                  style: TextStyle(fontSize: 23, color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 25, 118, 70)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(18))),
            ),
            Form(
                key: _formKey4,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 300,
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.monitor_weight_outlined,
                            color: Color.fromARGB(255, 25, 118, 70),
                          ),
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          labelText: 'Kilos',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) =>
                          this.novaEntrega.kilos = double.parse(value),
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      cursorColor: Color.fromARGB(255, 25, 118, 70),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Color.fromARGB(255, 25, 118, 70),
                          ),
                          labelStyle: (TextStyle(
                              color: Color.fromARGB(255, 25, 118, 70))),
                          labelText: 'Preço',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 25, 118, 70)))),
                      onSaved: (value) =>
                          this.novaEntrega.preco = double.parse(value),
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    ElevatedButton(
                      onPressed: () => lancar(context),
                      child: Text('Lançar',
                          style: TextStyle(fontSize: 23, color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 25, 118, 70)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(18))),
                    ),
                  ]),
                )),
          ],
        ),
      )),
    );
  }
}
