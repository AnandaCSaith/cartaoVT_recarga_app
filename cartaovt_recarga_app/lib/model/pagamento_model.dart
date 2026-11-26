
enum FormaPagamento {
  pix,
  cartaoCredito,
  boleto,
}

class PagamentoModel {
  final double valorRecarga;
  FormaPagamento formaPagamento;

  PagamentoModel({
    required this.valorRecarga,
    this.formaPagamento = FormaPagamento.pix,
  });
}
