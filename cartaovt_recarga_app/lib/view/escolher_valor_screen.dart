
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../view/pagamento_screen.dart';

import '../controllers/recarga_controller.dart';

class EscolherValorScreen extends StatefulWidget {
  const EscolherValorScreen({super.key});

  @override
  State<EscolherValorScreen> createState() =>
      _EscolherValorScreenState();
}

class _EscolherValorScreenState extends State<EscolherValorScreen> {
  final RecargaController controller = RecargaController();

  final TextEditingController campoOutroValor =
      TextEditingController();

  @override
  void dispose() {
    campoOutroValor.dispose();
    super.dispose();
  }

  // Seleciona um valor pronto e limpa o campo personalizado
  void selecionarValor(double valor) {
    setState(() {
      campoOutroValor.clear();
      controller.selecionarValor(valor);
    });
  }

  // Atualiza o valor personalizado
  void atualizarValorPersonalizado(String texto) {
    setState(() {
      controller.selecionarValorPersonalizado(texto);
    });
  }

  // Continua para a próxima etapa
  void continuar() {
  if (!controller.valorValido) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PagamentoScreen(
        valorRecarga: controller.valorSelecionado!,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final valores = controller.valoresDisponiveis;

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
              'Recarregar',
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

              const SizedBox(height: 16),

              // Título
              const Text(
                'Escolha um valor',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF52749A),
                ),
              ),

              const SizedBox(height: 8),

              // Opções de valores
              Row(
                children: valores.map((valor) {
                  final selecionado =
                      controller.valorSelecionado == valor;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),

                      child: GestureDetector(
                        onTap: () => selecionarValor(valor),

                        child: Container(
                          height: 47,
                          key: ValueKey('valor_$valor'),

                          decoration: BoxDecoration(
                            color: selecionado
                                ? const Color(0xFF27845B)
                                : const Color(0xFFD8E9DF),

                            borderRadius: BorderRadius.circular(9),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'R\$',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: selecionado
                                      ? Colors.white
                                      : const Color(0xFF52749A),
                                ),
                              ),

                              Text(
                                valor.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: selecionado
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 8),

              // Campo para outro valor
              TextField(
                controller: campoOutroValor,
                key: const ValueKey('campoOutroValor'),
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),

                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9,.]'),
                  ),
                ],

                onChanged: atualizarValorPersonalizado,

                decoration: InputDecoration(
                  hintText: 'R\$ Outro valor',

                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF52749A),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color(0xFF9AAFC5),
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color(0xFF9AAFC5),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color(0xFF27845B),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Botão continuar
              SizedBox(
                width: double.infinity,
                height: 38,

                child: ElevatedButton(
                  onPressed: controller.valorValido
                      ? continuar
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27845B),
                    disabledBackgroundColor:
                        const Color(0xFFB8C9C0),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  child: const Text(
                    'Continuar',
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
