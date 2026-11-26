
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';
import 'package:cartaovt_recarga_app/view/inicio_screen.dart';
import 'package:cartaovt_recarga_app/view/escolher_valor_screen.dart';

void main() {
  late InicioController inicio;

  setUp(() {
    inicio = InicioController();
  });

  // Teste 1: quatro opções de valores são exibidas
  testWidgets(
    'quatro opções de valores são exibidas',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EscolherValorScreen(inicio: inicio),
        ),
      );

      expect(find.byKey(const ValueKey('valor_10.0')), findsOneWidget);
      expect(find.byKey(const ValueKey('valor_20.0')), findsOneWidget);
      expect(find.byKey(const ValueKey('valor_30.0')), findsOneWidget);
      expect(find.byKey(const ValueKey('valor_50.0')), findsOneWidget);
    },
  );

  // Teste 2: campo Outro valor aceita digitação
  testWidgets(
    'campo Outro valor aceita digitação',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EscolherValorScreen(inicio: inicio),
        ),
      );

      final campo = find.byKey(
        const ValueKey('campoOutroValor'),
      );

      await tester.enterText(campo, '15,50');

      expect(
        tester.widget<TextField>(campo).controller!.text,
        '15,50',
      );
    },
  );

  // Teste 3: seleção de um valor limpa o outro campo
  testWidgets(
    'seleção de um valor limpa o outro campo',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EscolherValorScreen(inicio: inicio),
        ),
      );

      final campo = find.byKey(
        const ValueKey('campoOutroValor'),
      );

      await tester.enterText(campo, '15,50');
      await tester.pump();

      await tester.tap(
        find.byKey(const ValueKey('valor_20.0')),
      );
      await tester.pump();

      expect(
        tester.widget<TextField>(campo).controller!.text,
        '',
      );

      await tester.enterText(campo, '25,00');
      await tester.pump();

      // Verifica se a opção R$ 20 deixou de ficar selecionada
      final botao20 = tester.widget<Container>(
        find.byKey(const ValueKey('valor_20.0')),
      );

      final decoracao = botao20.decoration as BoxDecoration;

      expect(
        decoracao.color,
      const Color(0xFFD8E9DF),
      );
    },
  );

  // Teste 4: botão Continuar respeita o valor mínimo
  testWidgets(
    'botão Continuar respeita o valor mínimo de R\$ 10,00',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EscolherValorScreen(inicio: inicio),
        ),
      );

      final botao = find.widgetWithText(
        ElevatedButton,
        'Continuar',
      );

      expect(
        tester.widget<ElevatedButton>(botao).onPressed,
        isNull,
      );

      final campo = find.byKey(
        const ValueKey('campoOutroValor'),
      );

      await tester.enterText(campo, '9,99');
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(botao).onPressed,
        isNull,
      );

      await tester.enterText(campo, '10,00');
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(botao).onPressed,
        isNotNull,
      );
    },
  );

  // Teste 5: botão voltar retorna para a Tela 2
  testWidgets(
    'botão voltar retorna para a Tela 2',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InicioScreen(inicio: inicio),
        ),
      );

      await tester.tap(
        find.text('+ Recarregar saldo'),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(EscolherValorScreen),
        findsOneWidget,
      );

      await tester.tap(
        find.byIcon(Icons.arrow_back),
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(InicioScreen),
        findsOneWidget,
      );
    },
  );
}
