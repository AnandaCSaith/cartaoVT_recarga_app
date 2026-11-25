import 'package:cartaovt_recarga_app/model/recarga_model.dart';


class RecargaController {
  final RecargaModel recarga = RecargaModel();

  // Valores disponíveis para seleção
  final List<double> valoresDisponiveis = [
    10,
    20,
    30,
    50,
  ];

  // Seleciona um dos valores prontos
  void selecionarValor(double valor) {
    recarga.valorSelecionado = valor;
  }

  // Recebe um valor digitado pelo usuário
  void selecionarValorPersonalizado(String texto) {
    final textoFormatado = texto.replaceAll(',', '.');

    recarga.valorSelecionado = double.tryParse(textoFormatado);
  }

  // Verifica se o valor escolhido é válido
  bool get valorValido {
    return recarga.valorSelecionado != null &&
        recarga.valorSelecionado! >= 10;
  }

  // Retorna o valor selecionado
  double? get valorSelecionado {
    return recarga.valorSelecionado;
  }
}