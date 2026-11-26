
class PassageiroModel {
  final String nome;
  final String numeroCartao;
  double saldo;
  DateTime ultimaRecarga;

  PassageiroModel({
    required this.nome,
    required this.numeroCartao,
    required this.saldo,
    required this.ultimaRecarga,
  });

  String get numeroCartaoMascarado {
    if (numeroCartao.length <= 4) {
      return numeroCartao;
    }

    return '**** ${numeroCartao.substring(numeroCartao.length - 4)}';
  }
}
