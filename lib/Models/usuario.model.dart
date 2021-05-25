class Usuario {
  String idPessoa;
  String senha;
  String nome;
  String login;
  String email;
  String telefone;
  int status;

  Usuario(
      {this.idPessoa,
      this.senha,
      this.nome,
      this.email,
      this.telefone,
      this.status = 0});
}
