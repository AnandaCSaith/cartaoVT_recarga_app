
import 'package:cartaovt_recarga_app/model/pagamento_model.dart';


class PagamentoController {
  final PagamentoModel pagamento;

  PagamentoController({
    required double valorRecarga,
  }) : pagamento = PagamentoModel(
          valorRecarga: valorRecarga,
        );

  // Altera a forma de pagamento selecionada
  void selecionarFormaPagamento(FormaPagamento forma) {
    pagamento.formaPagamento = forma;
  }

  // Retorna o nome da forma de pagamento
  String get nomeFormaPagamento {
    switch (pagamento.formaPagamento) {
      case FormaPagamento.pix:
        return 'Pix';

      case FormaPagamento.cartaoCredito:
        return 'Cartão de crédito';

      case FormaPagamento.boleto:
        return 'Boleto';
    }
  }

  // Formata o valor da recarga
  String get valorFormatado {
    return 'R\$ ${pagamento.valorRecarga.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
