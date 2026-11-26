
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cartaovt_recarga_app/view/historico_screen.dart';
import 'package:cartaovt_recarga_app/view/inicio_screen.dart';
import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';

void main() {
  late InicioController inicio;

  setUp(() {
    inicio = InicioController();
  });

  // Teste 1: Movimentações aparecem da mais recente para a mais antiga
  testWidgets(
    'movimentações são exibidas da mais recente para a mais antiga',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HistoricoScreen(),
        ),
      );

      final posicaoRecarga = tester.getTopLeft(
        find.text('Recarga via Pix'),
      ).dy;

      final posicaoUso = tester.getTopLeft(
        find.text('Uso - Linha 420').first,
      ).dy;

      final posicaoRecargaAntiga = tester.getTopLeft(
        find.text('Recarga via cartão de crédito'),
      ).dy;

      final posicaoUsoAntigo = tester.getTopLeft(
        find.text('Uso - Linha 420').last,
      ).dy;

      expect(posicaoRecarga, lessThan(posicaoUso));
      expect(posicaoUso, lessThan(posicaoRecargaAntiga));
      expect(posicaoRecargaAntiga, lessThan(posicaoUsoAntigo));
    },
  );

  // Teste 2: Cada movimentação exibe data, hora, valor e descrição
  testWidgets(
    'cada movimentação exibe data, hora, valor e descrição',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HistoricoScreen(),
        ),
      );

      final ontem = DateTime.now().subtract(
        const Duration(days: 1),
      );

      final dia = ontem.day.toString().padLeft(2, '0');
      final mes = ontem.month.toString().padLeft(2, '0');
      final hora = ontem.hour.toString().padLeft(2, '0');
      final minuto = ontem.minute.toString().padLeft(2, '0');

      expect(find.text('Recarga via Pix'), findsOneWidget);
      expect(find.text('$dia/$mes às $hora:$minuto'), findsOneWidget);
      expect(find.text('+ R\$ 20,00'), findsOneWidget);
    },
  );

  // Teste 3: Lista de movimentações permite rolagem

testWidgets(
  'lista de movimentações permite rolagem',
  (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 250);
    tester.view.devicePixelRatio = 1;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        home: HistoricoScreen(),
      ),
    );

    final lista = find.byType(ListView);

    expect(lista, findsOneWidget);

    final scrollable = tester.state<ScrollableState>(
      find.descendant(
        of: lista,
        matching: find.byType(Scrollable),
      ),
    );

    expect(
      scrollable.position.maxScrollExtent,
      greaterThan(0),
    );

    scrollable.position.jumpTo(
      scrollable.position.maxScrollExtent,
    );

    await tester.pump();

    expect(
      scrollable.position.pixels,
      greaterThan(0),
    );
  },
);

  // Teste 4: Recargas verdes com + e usos vermelhos com -
  testWidgets(
    'recargas aparecem em verde com + e usos em vermelho com -',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HistoricoScreen(),
        ),
      );

      final credito = tester.widget<Text>(
        find.text('+ R\$ 20,00'),
      );

      final debito = tester.widget<Text>(
        find.text('- R\$ 15,00'),
      );

      expect(credito.style!.color, Colors.green);
      expect(debito.style!.color, Colors.red);

      expect(find.text('+ R\$ 20,00'), findsOneWidget);
      expect(find.text('- R\$ 15,00'), findsOneWidget);
    },
  );

  // Teste 5: Botão voltar retorna à Tela 2
  testWidgets(
    'botão voltar retorna para a Tela 2',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InicioScreen(inicio: inicio),
        ),
      );

      await tester.tap(find.text('Histórico'));
      await tester.pumpAndSettle();

      expect(find.byType(HistoricoScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(InicioScreen), findsOneWidget);
    },
  );
}
