class MovimentacaoModel {
  final DateTime data;
  final double valor;
  final String descricao;
  final bool isRecarga;

  MovimentacaoModel({
    required this.data,
    required this.valor,
    required this.descricao,
    required this.isRecarga,
  });
}