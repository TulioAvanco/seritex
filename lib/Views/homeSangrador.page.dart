import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Views/menu.drawer.Sangrador.dart';

class HomeSangrador extends StatefulWidget {
  @override
  _HomeSangradorState createState() => _HomeSangradorState();
}

class _HomeSangradorState extends State<HomeSangrador> {
  Future<dynamic> novoCorte(BuildContext context) async {
    await Navigator.of(context).pushNamed('/addCorte');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 25, 118, 70),
        centerTitle: true,
      ),
      endDrawer: MenuDrawerSangrador(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('sangradores')
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
            var prop = dados['uidProprietario'].toString();
            print(prop);
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('propriedades')
                    .doc(prop)
                    .snapshots(),
                builder: (BuildContext context, snapshot2) {
                  var dados2 = snapshot2.data;
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 25, 118, 70),
                        ),
                      ),
                    );
                  }
                  if (dados2 == null) {
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
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 200,
                            alignment: Alignment.center,
                            child: Center(
                              child: Image.asset(
                                  'assets/images/SeriTex_logo.png',
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
                                    Icons.house_outlined,
                                    color: Color.fromARGB(255, 25, 118, 70),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Text(
                                    dados2['propriedade'],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70)),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Icon(Icons.house_outlined,
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
                                    Icons.texture_outlined,
                                    color: Color.fromARGB(255, 25, 118, 70),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Text(
                                    dados2['qtdAlqueires'].toString(),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70)),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Icon(Icons.texture_outlined,
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
                                  Icon(Icons.park_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70)),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Text(
                                    dados2['qtdArvores'].toString(),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 118, 70)),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Icon(Icons.park_outlined,
                                      color: Color.fromARGB(255, 25, 118, 70)),
                                ],
                              )),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => novoCorte(context),
                            child: Text('Novo Corte',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white)),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 25, 118, 70)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(16))),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
