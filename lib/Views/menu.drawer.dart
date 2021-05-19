import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Text('Tulio Barbon Avanço',
                      style: TextStyle(color: Colors.white, fontSize: 18))
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Administração',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(Icons.assignment),
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
              'Adicionar Sangrador',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(Icons.person_add),
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
                    color: Color.fromARGB(255, 173, 46, 36), fontSize: 18),
              ),
              leading: Icon(
                Icons.logout,
                color: Color.fromARGB(255, 173, 46, 36),
              ),
            ),
          )
        ],
      ),
    );
  }
}
