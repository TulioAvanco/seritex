import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seritex/Views/addCorte.dart';
import 'package:seritex/Views/administracao.dart';
import 'package:seritex/Views/cadastro.page.dart';
import 'package:seritex/Views/cadastroSangrador.page.dart';
import 'package:seritex/Views/cotacao.page.dart';
import 'package:seritex/Views/homeAdmin.page.dart';
import 'package:seritex/Views/homeSangrador.page.dart';

import 'package:seritex/Views/login.page.dart';
import 'package:seritex/Views/nova.entrega.dart';
import 'package:seritex/Views/perfilUsuario.dart';
import 'package:seritex/Views/perflSangrador.dart';
import 'package:seritex/Views/totalentrega.dart';
import 'package:seritex/Views/ultimaentrega.dart';
import 'package:seritex/Views/ultimaentregaUsuario.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.light(primary: Color.fromARGB(255, 25, 118, 70)),
        primaryColor: Color.fromARGB(255, 25, 118, 70),
      ),
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
        '/addSangrador': (context) => CadastroSangrador(),
        '/novaEntrega': (context) => NovaEntrega(),
        '/ultimaEntregaSangrador': (context) => UltimaEntrega(),
        '/ultimaEntregaUsuario': (context) => UltimaEntregaUsuario(),
        '/totalEntregaUsuario': (context) => TotalEntregaUsuario(),
        '/perfilUsuario': (context) => PerfilUsuario(),
        '/perfilSangrador': (context) => PerfilSangrador(),
        '/administracao': (context) => Administracao()
      },
      initialRoute: '/',
    );
  }
}
