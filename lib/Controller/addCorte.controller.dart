import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/corte.model.dart';
import 'package:seritex/Models/entrega.model.dart';

class AddCorteController {
  String tabela;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String data;
  Entrega entrega = new Entrega();
  String ultimaEntraga;

  DateTime formata;
  Future<String> addCorte(Corte novoCorte) async {
    this.data = formatter.format(DateTime.now());
    this.formata = new DateFormat('dd-MM-yyyy').parse(novoCorte.data);
    novoCorte.data = formatter.format(this.formata);
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length != 0) {
        FirebaseFirestore.instance
            .collection('sangradores')
            .doc(uidLogado.uid)
            .collection('entregas')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            this.ultimaEntraga = doc['dataInicio'];
          });

          FirebaseFirestore.instance
              .collection('sangradores')
              .doc(uidLogado.uid)
              .collection('entregas')
              .doc(this.ultimaEntraga)
              .collection('cortes')
              .doc(novoCorte.data)
              .set({
            'data': novoCorte.data,
            'tabela': novoCorte.valor,
          });
        });
      } else {
        FirebaseFirestore.instance
            .collection('sangradores')
            .doc(uidLogado.uid)
            .collection('entregas')
            .doc(novoCorte.data)
            .set({
          'kilos': '',
          'dataInicio': novoCorte.data,
          'dataFinal': '',
          'preco': '',
        });

        FirebaseFirestore.instance
            .collection('sangradores')
            .doc(uidLogado.uid)
            .collection('entregas')
            .doc(novoCorte.data)
            .collection('cortes')
            .doc(novoCorte.data)
            .set({
          'data': novoCorte.data,
          'tabela': novoCorte.valor,
        });
      }
    });

    return this.tabela;
  }
}
