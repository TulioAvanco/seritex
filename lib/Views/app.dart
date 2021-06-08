import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seritex/Views/addCorte.dart';
import 'package:seritex/Views/cadastro.page.dart';
import 'package:seritex/Views/cadastroSangrador.page.dart';
import 'package:seritex/Views/cotacao.page.dart';
import 'package:seritex/Views/homeAdmin.page.dart';
import 'package:seritex/Views/homeSangrador.page.dart';

import 'package:seritex/Views/login.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Login(),
        '/cadastro': (context) => Cadastro(),
        '/homeadm': (context) => HomeAdm(),
        '/homeSangrador': (context) => HomeSangrador(),
        '/cotacao': (context) => Cotacao(),
        '/addCorte': (context) => AddCorte(),
        '/addSangrador': (context) => CadastroSangrador()
      },
      initialRoute: '/',
    );
  }
}
