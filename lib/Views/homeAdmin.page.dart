import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Views/menu.drawer.dart';

class HomeAdm extends StatefulWidget {
  @override
  _HomeAdmState createState() => _HomeAdmState();
}

Future<dynamic> novoCorte(BuildContext context) async {
  await Navigator.of(context).pushNamed('/addCorte');
}

class _HomeAdmState extends State<HomeAdm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
        centerTitle: true,
      ),
      endDrawer: MenuDrawer(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('propriedades')
              .doc(uidLogado.uid)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            var dados = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }
            if (dados == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 25, 118, 70),
                  ),
                ),
              );
            }

            return Center(
              child: Container(
                margin: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: Center(
                        child: Image.asset('assets/images/SeriTex_logo.png',
                            fit: BoxFit.fill),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            'Propriedade',
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 118, 70)),
                          ),
                        ),
                        subtitle: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cottage,
                              color: Color.fromARGB(255, 25, 118, 70),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              dados['propriedade'],
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 118, 70)),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Icon(Icons.cottage,
                                color: Color.fromARGB(255, 25, 118, 70)),
                          ],
                        )),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            'Alqueires',
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 118, 70)),
                          ),
                        ),
                        subtitle: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fence,
                              color: Color.fromARGB(255, 25, 118, 70),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              dados['qtdAlqueires'].toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 118, 70)),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Icon(Icons.fence,
                                color: Color.fromARGB(255, 25, 118, 70)),
                          ],
                        )),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            'Árvores',
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 118, 70)),
                          ),
                        ),
                        subtitle: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.park,
                                color: Color.fromARGB(255, 25, 118, 70)),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              dados['qtdArvores'].toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 25, 118, 70)),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Icon(Icons.park,
                                color: Color.fromARGB(255, 25, 118, 70)),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
