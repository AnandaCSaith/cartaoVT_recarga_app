import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';
import 'package:flutter/material.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key, required this.inicio});

  final InicioController inicio;

  @override
  State<StatefulWidget> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _abaAtual = 0;

  @override
  Widget build(BuildContext context) {
    //As abas 2 ainda provisórias: chegam nas issues #8.
    final abas = [
      InicioScreen(controller: widget.inicio),
      HistoricoScreen(controller: widget.inicio),
      PerfilScreen(sessao: widget.sessao),
    ];

    return Scaffold(
      body: SafeArea(child: abas[_abaAtual]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _abaAtual,
        onDestinationSelected: (i) => setState(() => _abaAtual = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Histórico',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
