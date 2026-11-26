
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';
import 'package:cartaovt_recarga_app/view/confirmacao_screen.dart';
import 'package:cartaovt_recarga_app/view/inicio_screen.dart';

void main() {
  late InicioController inicio;

  setUp(() {
    inicio = InicioController();
  });

  Widget criarTelaConfirmacao() {
    return MaterialApp(
      home: ConfirmacaoScreen(
        inicio: inicio,
        valorRecarga: 20.00,
        formaPagamento: 'Pix',
      ),
    );
  }

  testWidgets(
    'ícone de sucesso e mensagem de confirmação são exibidos',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTelaConfirmacao());

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Recarga concluída!'), findsOneWidget);
    },
  );

  testWidgets(
    'valor recarregado e número do cartão são exibidos',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTelaConfirmacao());

      expect(
        find.text('R\$ 20,00 adicionados ao cartão'),
        findsOneWidget,
      );

      expect(
        find.text('•••• 1234'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'novo saldo é calculado corretamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(criarTelaConfirmacao());

      // Saldo anterior: R$ 12,50
      // Recarga: R$ 20,00
      // Novo saldo esperado: R$ 32,50

      expect(
        find.text('R\$ 32,50'),
        findsOneWidget,
      );

      expect(inicio.passageiro.saldo, 32.50);
    },
  );

  testWidgets(
  'botão Voltar ao início retorna à Tela 2 com saldo atualizado',
  (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: InicioScreen(inicio: inicio),
      ),
    );

    // Abre a Tela 5 sobre a Tela 2.
    final navigator = tester.state<NavigatorState>(
      find.byType(Navigator),
    );

    navigator.push(
      MaterialPageRoute(
        builder: (_) => ConfirmacaoScreen(
          inicio: inicio,
          valorRecarga: 20.00,
          formaPagamento: 'Pix',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ConfirmacaoScreen), findsOneWidget);

    // Retorna diretamente para a Tela 2.
    await tester.tap(find.text('Voltar ao início'));
    await tester.pumpAndSettle();

    // Verifica se retornou à Tela 2.
    expect(find.byType(InicioScreen), findsOneWidget);
    expect(find.byType(ConfirmacaoScreen), findsNothing);

    // Verifica se o saldo foi atualizado no controller.
    expect(inicio.passageiro.saldo, 32.50);

    // Reconstrói a Tela 2 para atualizar o saldo exibido.
    await tester.pumpWidget(
      MaterialApp(
        home: InicioScreen(inicio: inicio),
      ),
    );

    // Verifica se o novo saldo aparece na interface.
    expect(find.text('R\$ 32,50'), findsOneWidget);
  },
);
}
