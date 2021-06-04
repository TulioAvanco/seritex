class Usuario {
  String idUser;
  String senha;
  String nome;
  String email;
  String telefone;
  int status;

  Usuario(
      {this.idUser,
      this.senha,
      this.nome,
      this.email,
      this.telefone,
      this.status = 0});
}
