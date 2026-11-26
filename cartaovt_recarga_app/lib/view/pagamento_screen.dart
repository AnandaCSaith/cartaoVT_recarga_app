
import 'package:cartaovt_recarga_app/model/pagamento_model.dart';
import 'package:flutter/material.dart';

import '../controllers/pagamento_controller.dart';
import '../view/confirmacao_screen.dart';

class PagamentoScreen extends StatefulWidget {
  final double valorRecarga;

  const PagamentoScreen({
    super.key,
    required this.valorRecarga,
  });

  @override
  State<PagamentoScreen> createState() => _PagamentoScreenState();
}

class _PagamentoScreenState extends State<PagamentoScreen> {
  late final PagamentoController controller;

  @override
  void initState() {
    super.initState();

    controller = PagamentoController(
      valorRecarga: widget.valorRecarga,
    );
  }

  // Confirma a forma de pagamento e abre a Tela 5
  void confirmarPagamento() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmacaoScreen(
          valorRecarga: controller.pagamento.valorRecarga,
          formaPagamento: controller.nomeFormaPagamento,
        ),
      ),
    );
  }

  // Monta cada opção de pagamento
  Widget opcaoPagamento({
    required FormaPagamento forma,
    required IconData icone,
    required String titulo,
    required String descricao,
  }) {
    final selecionado =
        controller.pagamento.formaPagamento == forma;

    return InkWell(
      key: ValueKey('forma_${forma.name}'),
      onTap: () {
        setState(() {
          controller.selecionarFormaPagamento(forma);
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),

        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFDCE3EA),
              width: 0.8,
            ),
          ),
        ),

        child: Row(
          children: [
            // Ícone
            Container(
              width: 34,
              height: 34,

              decoration: const BoxDecoration(
                color: Color(0xFFDCE8F6),
                shape: BoxShape.circle,
              ),

              child: Icon(
                icone,
                size: 18,
                color: const Color(0xFF3978AA),
              ),
            ),

            const SizedBox(width: 10),

            // Nome e descrição
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    descricao,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF52749A),
                    ),
                  ),
                ],
              ),
            ),

            // Indicador de seleção
            Icon(
              selecionado
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,

              size: 17,

              color: selecionado
                  ? const Color(0xFF27845B)
                  : const Color(0xFF9AAFC5),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFD),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFD),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 48,
        titleSpacing: 0,

        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back,
                size: 18,
                color: Colors.black87,
              ),
            ),

            const Text(
              'Forma de pagamento',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Valor da recarga
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF52749A),
                  ),

                  children: [
                    const TextSpan(
                      text: 'Valor da recarga: ',
                    ),

                    TextSpan(
                      text: controller.valorFormatado,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Opção Pix
              opcaoPagamento(
                forma: FormaPagamento.pix,
                icone: Icons.qr_code,
                titulo: 'Pix',
                descricao: 'Aprovação imediata',
              ),

              // Opção Cartão de crédito
              opcaoPagamento(
                forma: FormaPagamento.cartaoCredito,
                icone: Icons.credit_card,
                titulo: 'Cartão de crédito',
                descricao: 'Visa •••• 1234',
              ),

              // Opção Boleto
              opcaoPagamento(
                forma: FormaPagamento.boleto,
                icone: Icons.receipt_long,
                titulo: 'Boleto',
                descricao: 'Compensação em 1 dia útil',
              ),

              const Spacer(),

              // Botão confirmar pagamento
              SizedBox(
                width: double.infinity,
                height: 38,

                child: ElevatedButton(
                  onPressed: confirmarPagamento,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27845B),
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  child: const Text(
                    'Confirmar pagamento',
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
