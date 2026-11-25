import 'package:flutter/material.dart';

import '../controllers/inicio_controller.dart';
import 'historico_screen.dart';
import 'escolher_valor_screen.dart';

class InicioScreen extends StatefulWidget {
  final InicioController inicio;

  const InicioScreen({super.key, required this.inicio});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  InicioController get controller => widget.inicio;

  int itemSelecionado = 0;

  @override
  Widget build(BuildContext context) {
    final passageiro = controller.passageiro;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFD),

      body: SafeArea(
        child: Column(
          children: [
            // Conteúdo principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Saudação
                    Text(
                      'Olá, ${passageiro.nome}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Card de saldo
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5F3ED),
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Column(
                        children: [
                          const Text(
                            'Saldo disponível',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF52749A),
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            controller.formatarSaldo(),
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF27845B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Número do cartão
                    Text(
                      'Cartão ${passageiro.numeroCartaoMascarado}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF52749A),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Botão recarregar saldo
                    SizedBox(
                      width: double.infinity,
                      height: 38,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EscolherValorScreen(),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF27845B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),

                        child: const Text(
                          '+ Recarregar saldo',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Última recarga
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),

                      child: Text(
                        'Última recarga: ${controller.formatarUltimaRecarga()}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF52749A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Barra de navegação inferior
            Container(
              height: 54,
              decoration: const BoxDecoration(color: Color(0xFFF0F2F7)),

              child: Row(
                children: [
                  // Início
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          itemSelecionado = 0;
                        });
                      },

                      child: _itemNavegacao(
                        icone: Icons.home,
                        titulo: 'Início',
                        indice: 0,
                      ),
                    ),
                  ),

                  // Histórico
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          itemSelecionado = 1;
                        });

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoricoScreen(),
                          ),
                        );

                        if (mounted) {
                          setState(() {
                            itemSelecionado = 0;
                          });
                        }
                      },
                      child: _itemNavegacao(
                        icone: Icons.receipt_long,
                        titulo: 'Histórico',
                        indice: 1,
                      ),
                    ),
                  ),

                  // Perfil
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          itemSelecionado = 2;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Tela de Perfil ainda não implementada.',
                            ),
                          ),
                        );
                      },

                      child: _itemNavegacao(
                        icone: Icons.person,
                        titulo: 'Perfil',
                        indice: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para montar cada item da navegação
  Widget _itemNavegacao({
    required IconData icone,
    required String titulo,
    required int indice,
  }) {
    bool selecionado = itemSelecionado == indice;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),

          decoration: BoxDecoration(
            color: selecionado ? const Color(0xFFD5E3F5) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Icon(
            icone,
            size: 17,
            color: selecionado
                ? const Color(0xFF27845B)
                : const Color(0xFF6C4A8E),
          ),
        ),

        Text(
          titulo,
          style: TextStyle(
            fontSize: 10,
            fontWeight: selecionado ? FontWeight.bold : FontWeight.normal,
            color: selecionado ? Colors.black87 : const Color(0xFF52749A),
          ),
        ),
      ],
    );
  }
}
