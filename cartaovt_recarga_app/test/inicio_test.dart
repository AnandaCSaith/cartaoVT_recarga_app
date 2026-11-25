
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';
import 'package:cartaovt_recarga_app/view/inicio_screen.dart';
import 'package:cartaovt_recarga_app/view/escolher_valor_screen.dart';
import 'package:cartaovt_recarga_app/view/historico_screen.dart';

void main() {
  late InicioController inicio;

  setUp(() {
    inicio = InicioController();
  });

  Widget criarTela() {
    return MaterialApp(
      home: InicioScreen(inicio: inicio),
    );
  }

  testWidgets(
    'nome e saldo são exibidos corretamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTela());

      expect(find.text('Olá, Marina'), findsOneWidget);
      expect(find.text('R\$ 12,50'), findsOneWidget);
    },
  );

  testWidgets(
    'data e horário da última recarga são exibidos',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTela());

      expect(
        find.text('Última recarga: 03/11 às 08:12'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'barra inferior exibe os três itens',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTela());

      expect(find.text('Início'), findsOneWidget);
      expect(find.text('Histórico'), findsOneWidget);
      expect(find.text('Perfil'), findsOneWidget);
    },
  );

  testWidgets(
    'botão Recarregar saldo abre a Tela 3',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTela());

      await tester.tap(find.text('+ Recarregar saldo'));
      await tester.pumpAndSettle();

      expect(find.byType(EscolherValorScreen), findsOneWidget);
    },
  );

  testWidgets(
    'item Histórico abre a Tela 6',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTela());

      await tester.tap(find.text('Histórico'));
      await tester.pumpAndSettle();

      expect(find.byType(HistoricoScreen), findsOneWidget);
    },
  );
}
