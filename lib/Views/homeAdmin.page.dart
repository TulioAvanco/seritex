import 'package:flutter/material.dart';
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
      drawer: MenuDrawer(),
      body: ListView(
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
      ),
    );
  }
}
