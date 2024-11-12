class Animal {
  String id;
  String nome;
  String categoria;
  String sexo;
  String descricao;

  Animal({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.sexo,
    required this.descricao
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      categoria: json['categoria'] ?? '',
      sexo: json['sexo'] ?? '',
      descricao: json['descricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'sexo': sexo,
      'descricao': descricao
    };
  }
}