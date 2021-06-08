import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovaEntrega extends StatefulWidget {
  const NovaEntrega({Key key}) : super(key: key);

  @override
  _NovaEntregaState createState() => _NovaEntregaState();
}

class _NovaEntregaState extends State<NovaEntrega> {
  final _formKey4 = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
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
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: _formKey4,
                child: Column(children: [
                  TextFormField(
                    cursorColor: Color.fromARGB(255, 25, 118, 70),
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 25, 118, 70),
                        ),
                        labelStyle: (TextStyle(
                            color: Color.fromARGB(255, 25, 118, 70))),
                        labelText: 'Data',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 118, 70))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 25, 118, 70)))),
                  ),
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
                  ),
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
                  )
                ])),
          ],
        ),
      )),
    );
  }
}
