import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seritex/Controller/cadastro.controller.dart';
import 'package:seritex/Models/corte.model.dart';

class AddCorteController {
  String tabela;
  Future<String> novoCorte(Corte novoCorte) async {
    await FirebaseFirestore.instance
        .collection('sangradores')
        .doc(uidLogado.uid)
        .collection('cortes')
        .doc(novoCorte.data)
        .set({
      'data': novoCorte.data,
      'tabela': novoCorte.valor,
    });
    return this.tabela;
  }
}
