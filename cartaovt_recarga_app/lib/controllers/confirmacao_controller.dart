
import '../model/recarga_model.dart';
import 'inicio_controller.dart';

class ConfirmacaoController {
  final InicioController inicio;
  late final RecargaModel recarga;

  double? novoSaldo;
  bool _recargaConfirmada = false;

  ConfirmacaoController({
    required this.inicio,
    required double valorRecarga,
  }) {
    recarga = RecargaModel(
      valorSelecionado: valorRecarga,
      dataRecarga: DateTime.now(),
    );
  }

  // Atualiza o saldo do passageiro
  void confirmarRecarga() {
    if (_recargaConfirmada) return;

    final valor = recarga.valorSelecionado!;

    inicio.passageiro.saldo += valor;
    inicio.passageiro.ultimaRecarga = recarga.dataRecarga!;

    novoSaldo = inicio.passageiro.saldo;

    _recargaConfirmada = true;
  }

  // Formata o novo saldo
  String get novoSaldoFormatado {
    return 'R\$ ${novoSaldo!.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  // Formata o valor adicionado
  String get valorRecargaFormatado {
    return 'R\$ ${recarga.valorSelecionado!.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  // Retorna os últimos quatro dígitos do cartão
  String get cartaoMascarado {
    final numero = inicio.passageiro.numeroCartao;

    final ultimosDigitos = numero.length > 4
        ? numero.substring(numero.length - 4)
        : numero;

    return '•••• $ultimosDigitos';
  }
}
