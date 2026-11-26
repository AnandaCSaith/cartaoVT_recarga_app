
import 'package:flutter/material.dart';

import '../controllers/inicio_controller.dart';

class PerfilScreen extends StatelessWidget {
  final InicioController inicio;

  const PerfilScreen({
    super.key,
    required this.inicio,
  });

  void _mostrarDadosCartao(BuildContext context) {
    final passageiro = inicio.passageiro;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dados do cartão'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nome do passageiro'),
            Text(
              passageiro.nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            const Text('Número do cartão'),
            Text(
              passageiro.numeroCartaoMascarado,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            const Text('Saldo disponível'),
            Text(
              inicio.formatarSaldo(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF27845B),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _mostrarAjuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(
              Icons.help_outline,
              color: Color(0xFF27845B),
            ),
            SizedBox(width: 8),
            Text('Ajuda'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Como realizar uma recarga?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Na tela inicial, toque em "Recarregar saldo", '
              'escolha o valor desejado e selecione a forma de pagamento.',
            ),
            SizedBox(height: 16),
            Text(
              'Meu saldo não foi atualizado. O que fazer?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Verifique se a recarga foi concluída. '
              'Caso o problema continue, procure o atendimento '
              'responsável pelo cartão de transporte.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }

  void _mostrarSobre(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'CartãoVT Recarga',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.directions_bus,
        size: 40,
        color: Color(0xFF27845B),
      ),
      children: const [
        Text(
          'Aplicativo desenvolvido para facilitar '
          'a consulta de saldo e a realização de recargas '
          'do cartão de transporte.',
        ),
        SizedBox(height: 12),
        Text(
          'Projeto acadêmico.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final passageiro = inicio.passageiro;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFD),

      appBar: AppBar(
        title: const Text(
          'Meu perfil',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFAFBFD),
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFE5F3ED),
            child: Icon(
              Icons.person,
              size: 45,
              color: Color(0xFF27845B),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            passageiro.nome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Cartão ${passageiro.numeroCartaoMascarado}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF52749A),
            ),
          ),

          const SizedBox(height: 30),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.credit_card,
              color: Color(0xFF27845B),
            ),
            title: const Text(
              'Dados do cartão',
              style: TextStyle(fontSize: 13),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _mostrarDadosCartao(context),
          ),

          ListTile(
            leading: const Icon(
              Icons.help_outline,
              color: Color(0xFF27845B),
            ),
            title: const Text(
              'Ajuda',
              style: TextStyle(fontSize: 13),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _mostrarAjuda(context),
          ),

          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Color(0xFF27845B),
            ),
            title: const Text(
              'Sobre o aplicativo',
              style: TextStyle(fontSize: 13),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _mostrarSobre(context),
          ),
        ],
      ),
    );
  }
}
