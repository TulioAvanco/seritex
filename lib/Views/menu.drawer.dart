import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDrawer extends StatelessWidget {
  sair(BuildContext context) {
    CadastroController().logout();
    Navigator.of(context).pushNamed('/');
  }

  Future<void> abrirUrl() async {
    const url = 'http://www.anrpc.org/html/daily-prices.aspx?';
    await launch(url, forceWebView: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
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
                  onTap: () =>
                      Navigator.of(context).pushNamed('/administracao'),
                  title: Text(
                    'Administra????o',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.assignment),
                ),
                ListTile(
                  title: Text(
                    'Adicionar Sangrador',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/addSangrador'),
                  leading: Icon(Icons.person_add_outlined),
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
                  onTap: () =>
                      Navigator.of(context).pushNamed('/perfilUsuario'),
                  title: Text(
                    'Perfil',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.account_circle_outlined),
                ),
                ListTile(
                  title: Text(
                    'Ultimas Entregas',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed('/ultimaEntregaUsuario'),
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
