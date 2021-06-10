import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/entrega.model.dart';

class AddEntrega {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  String data;
  String ultimaEntraga;
  DateTime novaData;

  addEntrega(Entrega entrega) {
    print(entrega);
    FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        entrega.dataInicio = doc['dataInicio'];
      });
      FirebaseFirestore.instance
          .collection('sangradores')
          .doc(uidLogado.uid)
          .collection('entregas')
          .doc(entrega.dataInicio)
          .set({
        'kilos': entrega.kilos,
        'dataInicio': entrega.dataInicio,
        'dataFinal': entrega.dataFinal,
        'preco': entrega.preco,
      });
      this.novaData = new DateFormat('dd-MM-yyyy').parse(entrega.dataFinal);
      print(this.novaData);
      this.novaData.add(const Duration(days: 1));
      this.data = this.formatter.format(this.novaData);
      FirebaseFirestore.instance
          .collection('sangradores')
          .doc(uidLogado.uid)
          .collection('entregas')
          .doc(this.data)
          .set({
        'kilos': '',
        'dataInicio': this.data,
        'dataFinal': '',
        'preco': '',
      });
    });
  }
}
