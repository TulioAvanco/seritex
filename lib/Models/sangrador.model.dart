import 'package:seritex/Models/usuario.model.dart';

class Sangrador extends Usuario {
  String idProprietario;
  String tabelas;
  Sangrador({this.idProprietario, this.tabelas = '1'});
}
