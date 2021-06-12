import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/usuario.model.dart';
import 'package:seritex/Views/homeSangrador.page.dart';
import 'package:strings/strings.dart';

// ignore: must_be_immutable
class MenuDrawerSangrador extends StatefulWidget {
  @override
  _MenuDrawerSangradorState createState() => _MenuDrawerSangradorState();
}

class _MenuDrawerSangradorState extends State<MenuDrawerSangrador> {
  sair(BuildContext context) {
    CadastroController().logout();

    Navigator.of(context).pushNamed('/');
  }

  Usuario sangrador = new Usuario();

  Future<String> pegarnome() async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .where('uid', isEqualTo: uidLogado.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.sangrador.nome = doc['nome'];
      });
    });

    this.sangrador.nome = capitalize(this.sangrador.nome);

    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    print('build do drawer');

    Function callBack = () {
      HomeSangrador().createState().read2();
    };

    return FutureBuilder(
      future: pegarnome(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Drawer(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  color: Color.fromARGB(255, 25, 118, 70),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            child: Image.asset(
                              'assets/images/SeriTex_icon.png',
                              fit: BoxFit.fill,
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 8)),
                        Text(this.sangrador.nome,
                            style: TextStyle(color: Colors.white, fontSize: 18))
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Cotação da Borracha',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.bar_chart),
                ),
                ListTile(
                  title: Text(
                    'Ultimas Entregas',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.inbox),
                ),
                ListTile(
                  title: Text(
                    'Nova Entrega',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => HomeSangrador()
                      .createState()
                      .novaEntrega(context, callBack),
                  leading: Icon(Icons.move_to_inbox_outlined),
                ),
                ListTile(
                  title: Text(
                    'Perfil',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.account_circle_rounded),
                ),
                Container(
                  child: ListTile(
                    title: Text(
                      'Sair',
                      style: TextStyle(
                          color: Color.fromARGB(255, 173, 46, 36),
                          fontSize: 18),
                    ),
                    onTap: () => sair(context),
                    leading: Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 173, 46, 36),
                    ),
                  ),
                )
              ],
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
}
