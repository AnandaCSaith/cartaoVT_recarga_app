import 'package:cartaovt_recarga_app/model/movimentacao_model.dart';
import 'package:flutter/material.dart';

class HistoricoController extends ChangeNotifier {

  List<MovimentacaoModel> movimentacoes = [
    MovimentacaoModel(
      data: DateTime.now().subtract(const Duration(days: 1)),
      valor: 20.0,
      descricao: 'Recarga via Pix',
      isRecarga: true,
    ),

    MovimentacaoModel(
      data: DateTime.now().subtract(const Duration(days: 2)),
      valor: 15.0,
      descricao: 'Uso - Linha 420',
      isRecarga: false,
    ),

    MovimentacaoModel(
      data: DateTime.now().subtract(const Duration(days: 2)),
      valor: 5.0,
      descricao: 'Uso - Linha 115',
      isRecarga: false,
    ),

    MovimentacaoModel(
      data: DateTime.now().subtract(const Duration(days: 3)),
      valor: 30.0,
      descricao: 'Recarga via cartão de crédito',
      isRecarga: true,
    ),

    MovimentacaoModel(
      data: DateTime.now().subtract(const Duration(days: 4)),
      valor: 10.0,
      descricao: 'Uso - Linha 420',
      isRecarga: false,
    ),
  ];

  List<MovimentacaoModel> getHistorico() {
    movimentacoes.sort(
      (a, b) => b.data.compareTo(a.data)
    );
    return movimentacoes;
  }
}
