import 'package:cartaovt_recarga_app/controllers/historico_controller.dart';
import 'package:flutter/material.dart';

class HistoricoScreen extends StatelessWidget {
  HistoricoScreen({super.key});

  final HistoricoController controller = HistoricoController();

  String formatarData(DateTime data) {
    String dia = data.day.toString().padLeft(2, '0');
    String mes = data.month.toString().padLeft(2, '0');

    String hora = data.hour.toString().padLeft(2, '0');
    String minuto = data.minute.toString().padLeft(2, '0');

    return '$dia/$mes às $hora:$minuto';
  }

  String formatarValor(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    final movimentacoes = controller.getHistorico();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFD),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                        SizedBox(width: 5),
                        Text(
                          'Histórico',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: movimentacoes.length,
                itemBuilder: (context, index) {
                  final movimentacao = movimentacoes[index];

                  final cor = movimentacao.isRecarga
                      ? Colors.green
                      : Colors.red;

                  final sinal = movimentacao.isRecarga ? '+' : '-';

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                      ),
                    ),

                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: const Color(0xFFE0E0E0),
                          child: Icon(
                            movimentacao.isRecarga
                                ? Icons.credit_card
                                : Icons.directions_bus,
                            color: const Color(0xFF2c7952),
                            size: 17,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movimentacao.descricao,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formatarData(movimentacao.data),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),

                        Text(
                          '$sinal ${formatarValor(movimentacao.valor)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: cor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
