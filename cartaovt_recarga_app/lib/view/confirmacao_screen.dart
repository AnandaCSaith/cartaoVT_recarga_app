
import 'package:flutter/material.dart';

import '../controllers/inicio_controller.dart';
import '../controllers/confirmacao_controller.dart';

class ConfirmacaoScreen extends StatefulWidget {
  final InicioController inicio;
  final double valorRecarga;
  final String formaPagamento;

  const ConfirmacaoScreen({
    super.key,
    required this.inicio,
    required this.valorRecarga,
    required this.formaPagamento,
  });

  @override
  State<ConfirmacaoScreen> createState() =>
      _ConfirmacaoScreenState();
}

class _ConfirmacaoScreenState extends State<ConfirmacaoScreen> {
  late final ConfirmacaoController controller;

  @override
  void initState() {
    super.initState();

    controller = ConfirmacaoController(
      inicio: widget.inicio,
      valorRecarga: widget.valorRecarga,
    );

    // Realiza a atualização do saldo
    controller.confirmarRecarga();
  }

  // Retorna diretamente para a Tela 2
  void voltarAoInicio() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFD),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            children: [
              const SizedBox(height: 35),

              // Ícone de sucesso
              Container(
                width: 40,
                height: 40,

                decoration: BoxDecoration(
                  color: const Color(0xFF55C98B),
                  borderRadius: BorderRadius.circular(6),
                ),

                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 34,
                ),
              ),

              const SizedBox(height: 18),

              // Mensagem de confirmação
              const Text(
                'Recarga concluída!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF27845B),
                ),
              ),

              const SizedBox(height: 12),

              // Valor adicionado
              Text(
                '${controller.valorRecargaFormatado} adicionados ao cartão',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF52749A),
                ),
              ),

              const SizedBox(height: 3),

              // Número do cartão
              Text(
                controller.cartaoMascarado,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF52749A),
                ),
              ),

              const SizedBox(height: 10),

              // Card com novo saldo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F7),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Novo saldo',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    Text(
                      controller.novoSaldoFormatado,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF27845B),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Botão voltar ao início
              SizedBox(
                width: double.infinity,
                height: 38,

                child: ElevatedButton(
                  onPressed: voltarAoInicio,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27845B),
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  child: const Text(
                    'Voltar ao início',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
