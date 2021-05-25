import 'package:flutter/material.dart';
import 'package:seritex/Views/menu.drawer.dart';

class HomeAdm extends StatefulWidget {
  @override
  _HomeAdmState createState() => _HomeAdmState();
}

class _HomeAdmState extends State<HomeAdm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
        centerTitle: true,
      ),
      drawer: MenuDrawer(),
    );
  }
}
