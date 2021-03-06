import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/usuario.model.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> abrirUrl() async {
    const url = 'http://www.anrpc.org/html/daily-prices.aspx?';
    await launch(url, forceWebView: false);
  }

  Usuario sangrador = new Usuario();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sangradores')
          .doc(uidLogado.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            radius: 50,
                            backgroundImage:
                                NetworkImage(snapshot.data['imagem']),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 8)),
                        Text(snapshot.data['nome'],
                            style: TextStyle(color: Colors.white, fontSize: 18))
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => abrirUrl(),
                  title: Text(
                    'Cota????o da Borracha',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.bar_chart_outlined),
                ),
                ListTile(
                  title: Text(
                    'Nova Entrega',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/novaEntrega'),
                  leading: Icon(Icons.move_to_inbox_outlined),
                ),
                ListTile(
                  title: Text(
                    'Perfil',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed('/perfilSangrador'),
                  leading: Icon(Icons.account_circle_outlined),
                ),
                ListTile(
                  title: Text(
                    'Ultimas Entregas',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed('/ultimaEntregaSangrador'),
                  leading: Icon(Icons.local_shipping_outlined),
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
                      Icons.logout_outlined,
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
