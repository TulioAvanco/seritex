import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/entrega.model.dart';

class AddEntrega {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String data;
  String ultimaEntraga;
  DateTime novaData;
  DateTime formata;
  Entrega entregaProprietatio = new Entrega();
  String uidProprietario;
  addEntrega(Entrega entrega) async {
    double percentual;
    print(entrega.dataFinal);
    this.formata = new DateFormat('dd-MM-yyyy').parse(entrega.dataFinal);
    entrega.dataFinal = formatter.format(this.formata).toString();

    this.entregaProprietatio.dataFinal = entrega.dataFinal.toString();
    this.entregaProprietatio.dataInicio = entrega.dataInicio.toString();
    this.entregaProprietatio.kilos = entrega.kilos.toDouble();
    this.entregaProprietatio.preco = entrega.preco.toDouble();
    print(entrega.dataFinal);
    await FirebaseFirestore.instance
        .collection('sangradores')
        .where('uid', isEqualTo: uidLogado.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        percentual = double.parse(doc['percentual'].toString());
      });
    });
    entrega.kilos = entrega.kilos * percentual * 0.01;
    entregaProprietatio.kilos =
        entregaProprietatio.kilos * (100 - percentual) * 0.01;

    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        entrega.dataInicio = doc['dataInicio'];
      });
      this.entregaProprietatio.dataInicio = entrega.dataInicio.toString();
    });
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('entregas')
        .doc(entrega.dataInicio)
        .set({
      'kilos': entrega.kilos,
      'dataInicio': entrega.dataInicio,
      'dataFinal': entrega.dataFinal,
      'preco': entrega.preco,
      'caixas': entrega.caixas
    });
    this.novaData = new DateFormat('yyyy-MM-dd').parse(entrega.dataFinal);
    this.novaData = this.novaData.add(Duration(days: 1));
    this.data = this.formatter.format(this.novaData);
    await FirebaseFirestore.instance
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
    await FirebaseFirestore.instance
        .collection('sangradores')
        .where('uid', isEqualTo: uidLogado.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        this.uidProprietario = doc['uidProprietario'];
      });
    });

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(this.uidProprietario)
        .collection('entregas')
        .doc(this.entregaProprietatio.dataFinal)
        .set({
      'dataFinal': this.entregaProprietatio.dataFinal,
    });

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(this.uidProprietario)
        .collection('entregas')
        .doc(this.entregaProprietatio.dataFinal)
        .collection('peloSangrador')
        .doc(uidLogado.uid)
        .set({
      'kilos': this.entregaProprietatio.kilos,
      'dataInicio': this.entregaProprietatio.dataInicio,
      'dataFinal': this.entregaProprietatio.dataFinal,
      'preco': this.entregaProprietatio.preco,
      'uidSangrador': uidLogado.uid,
    });
  }
}
