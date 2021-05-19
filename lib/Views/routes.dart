import 'package:flutter/material.dart';
import 'package:seritex/Views/Login.page.dart';
import 'package:seritex/Views/cadastro.page.dart';
import 'package:seritex/Views/cotacao.page.dart';
import 'package:seritex/Views/homeAdmin.page.dart';

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        '/cadastro': (context) => Cadastro(),
        '/homeadm': (context) => HomeAdm(),
        '/cotacao': (context) => Cotacao(),
      },
      initialRoute: '/cotacao',
    );
  }
}
