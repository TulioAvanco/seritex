import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:seritex/Views/menu.drawer.dart';

class AddCorte extends StatefulWidget {
  @override
  _AddCorteState createState() => _AddCorteState();
}

class _AddCorteState extends State<AddCorte> {
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Corte'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                    Text(currentDate.toString(),
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
                    Padding(padding: EdgeInsets.only(bottom: 32))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
