import 'package:flutter/material.dart';
import 'package:seritex/Views/menu.drawer.dart';

class Cotacao extends StatefulWidget {
  @override
  _CotacaoState createState() => _CotacaoState();
}

class _CotacaoState extends State<Cotacao> {
  String? _cotacao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Cotação'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 25, 118, 70)),
      drawer: MenuDrawer(),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  Container(
                    child: DropdownButton<String>(
                      onChanged: (novoValor) {
                        setState(() {
                          _cotacao = novoValor;
                        });
                      },
                      style: const TextStyle(fontSize: 16),
                      underline: Container(
                        height: 2,
                        color: Color.fromARGB(255, 25, 118, 70),
                      ),
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Color.fromARGB(255, 25, 118, 70),
                      ),
                      hint: Text('Escolha a Série'),
                      value: (_cotacao),
                      items: <String>['Coagulo', 'Coagulo1', 'Latex']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
