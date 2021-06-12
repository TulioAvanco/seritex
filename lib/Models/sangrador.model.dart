import 'package:seritex/Models/usuario.model.dart';

class Sangrador extends Usuario {
  String idProprietario;
  String tabelas;
  double percentual;
  Sangrador({this.idProprietario, this.tabelas = '1', this.percentual = 0});
}
