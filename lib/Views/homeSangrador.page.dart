import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/entrega.model.dart';
import 'package:seritex/Views/menu.drawer.Sangrador.dart';
import 'package:seritex/Views/nova.entrega.dart';

class HomeSangrador extends StatefulWidget {
  @override
  _HomeSangradorState createState() => _HomeSangradorState();
}

class _HomeSangradorState extends State<HomeSangrador> {
  Future<dynamic> novoCorte(BuildContext context) async {
    await Navigator.of(context).pushNamed('/addCorte');
  }

  novaEntrega(BuildContext context, Function callback) async {
    //NovaEntrega({Key key})

    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NovaEntrega(callback)));
  }

  Entrega ultimaEntrega = new Entrega();
  List<String> ultima = [];
  int indice;

  Future<Entrega> read() async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 0 || querySnapshot.docs.length == 1) {
        this.ultimaEntrega.dataFinal = '0';
        this.ultimaEntrega.dataInicio = '0';
        this.ultimaEntrega.kilos = 0;
        this.ultimaEntrega.preco = 0;
      }
    });
    if (this.ultimaEntrega.dataFinal == '0') {
      return this.ultimaEntrega;
    }

    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.ultima.add(doc['dataInicio']);
      });
      if (this.ultima.length > 1) {
        this.indice = this.ultima.length - 2;
      } else {
        this.indice = 0;
      }
    });
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .where('dataInicio', isEqualTo: this.ultima[this.indice])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.ultimaEntrega.dataFinal = doc['dataFinal'];
        this.ultimaEntrega.dataInicio = doc['dataInicio'];
        this.ultimaEntrega.kilos = doc['kilos'];
        this.ultimaEntrega.preco = doc['preco'];
      });
      print(this.ultimaEntrega.preco);
    });
    return this.ultimaEntrega;
  }

  Future<Entrega> read2() async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 0 || querySnapshot.docs.length == 1) {
        setState(() {
          this.ultimaEntrega.dataFinal = '0';
          this.ultimaEntrega.dataInicio = '0';
          this.ultimaEntrega.kilos = 0;
          this.ultimaEntrega.preco = 0;
        });
      }
    });
    if (this.ultimaEntrega.dataFinal == '0') {
      return this.ultimaEntrega;
    }

    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.ultima.add(doc['dataInicio']);
      });
      if (this.ultima.length > 1) {
        this.indice = this.ultima.length - 2;
      } else {
        this.indice = 0;
      }
    });
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .where('dataInicio', isEqualTo: this.ultima[this.indice])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          this.ultimaEntrega.dataFinal = doc['dataFinal'];
          this.ultimaEntrega.dataInicio = doc['dataInicio'];
          this.ultimaEntrega.kilos = doc['kilos'];
          this.ultimaEntrega.preco = doc['preco'];
        });
      });
      print(this.ultimaEntrega.preco);
    });
    return this.ultimaEntrega;
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Color.fromARGB(255, 25, 118, 70),
          centerTitle: true,
        ),
        endDrawer: MenuDrawerSangrador(),
        body: FutureBuilder<Entrega>(
            future: read(),
            builder: (BuildContext context, AsyncSnapshot<Entrega> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 25, 118, 70),
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return pagina(snapshot.data);
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 25, 118, 70),
                    ),
                  ),
                );
              }
            }));
  }

  pagina(Entrega dados) {
    return ListView(
      children: [
        Padding(padding: EdgeInsets.only(top: 28)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ultima Entrega',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 25, 118, 70)),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 32)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Data',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text(dados.dataFinal),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Color.fromARGB(255, 25, 118, 70),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'kilos',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text(dados.kilos.toString()),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Icon(
                    Icons.monitor_weight_outlined,
                    color: Color.fromARGB(255, 25, 118, 70),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Preço',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text(dados.preco.toString()),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Icon(
                    Icons.price_change_outlined,
                    color: Color.fromARGB(255, 25, 118, 70),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 28)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Proxima Entrega',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 25, 118, 70)),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 32)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Dias',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text('teste'),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Icon(
                    Icons.next_week_outlined,
                    color: Color.fromARGB(255, 25, 118, 70),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Cortes',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text('teste'),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Icon(
                    Icons.park_outlined,
                    color: Color.fromARGB(255, 25, 118, 70),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Previsão',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Text('teste'),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 25, 118, 70)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Icon(
                    Icons.insights_outlined,
                    color: Color.fromARGB(255, 25, 118, 70),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 50)),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          child: ElevatedButton(
            onPressed: () => novoCorte(context),
            child: Text('Novo Corte'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 25, 118, 70))),
          ),
        )
      ],
    );
  }
}
