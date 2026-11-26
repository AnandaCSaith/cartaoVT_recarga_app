
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';
import 'package:cartaovt_recarga_app/view/inicio_screen.dart';
import 'package:cartaovt_recarga_app/view/pagamento_screen.dart';
import 'package:cartaovt_recarga_app/view/escolher_valor_screen.dart';
import 'package:cartaovt_recarga_app/view/confirmacao_screen.dart';

void main() {
  late InicioController inicio;

  setUp(() {
    inicio = InicioController();
  });

  // Teste 1: valor da recarga é exibido corretamente
  testWidgets(
  'valor da recarga é exibido corretamente',
  (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PagamentoScreen(
          valorRecarga: 20.00,
          inicio: inicio,
        ),
      ),
    );

    final richTexts = tester.widgetList<RichText>(
      find.byType(RichText),
    );

    final textoExibido = richTexts
        .map((richText) => richText.text.toPlainText())
        .join(' ');

    expect(textoExibido, contains('R\$ 20,00'));
  },
);

  // Teste 2: três formas de pagamento são exibidas
  testWidgets(
    'três formas de pagamento são exibidas',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PagamentoScreen(
            valorRecarga: 20.00,
            inicio: inicio,
          ),
        ),
      );

      expect(find.text('Pix'), findsOneWidget);
      expect(find.text('Cartão de crédito'), findsOneWidget);
      expect(find.text('Boleto'), findsOneWidget);

      expect(find.text('Aprovação imediata'), findsOneWidget);
      expect(find.text('Visa •••• 1234'), findsOneWidget);
      expect(find.text('Compensação em 1 dia útil'), findsOneWidget);
    },
  );

  // Teste 3: apenas uma forma de pagamento pode ser selecionada
  testWidgets(
    'apenas uma forma de pagamento pode ser selecionada',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PagamentoScreen(
            valorRecarga: 20.00,
            inicio: inicio,
          ),
        ),
      );

      // Pix vem selecionado inicialmente
      expect(
        find.byIcon(Icons.radio_button_checked),
        findsOneWidget,
      );

      // Seleciona Cartão de crédito
      await tester.tap(
        find.byKey(
          const ValueKey('forma_cartaoCredito'),
        ),
      );

      await tester.pump();

      expect(
        find.byIcon(Icons.radio_button_checked),
        findsOneWidget,
      );

      // Verifica se o cartão está selecionado
      expect(
        find.descendant(
          of: find.byKey(
            const ValueKey('forma_cartaoCredito'),
          ),
          matching: find.byIcon(Icons.radio_button_checked),
        ),
        findsOneWidget,
      );

      // Seleciona Boleto
      await tester.tap(
        find.byKey(
          const ValueKey('forma_boleto'),
        ),
      );

      await tester.pump();

      expect(
        find.byIcon(Icons.radio_button_checked),
        findsOneWidget,
      );

      expect(
        find.descendant(
          of: find.byKey(
            const ValueKey('forma_boleto'),
          ),
          matching: find.byIcon(Icons.radio_button_checked),
        ),
        findsOneWidget,
      );
    },
  );

  // Teste 4: botão Confirmar pagamento abre a Tela 5
  testWidgets(
    'botão Confirmar pagamento abre a Tela 5',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PagamentoScreen(
            valorRecarga: 20.00,
            inicio: inicio,
          ),
        ),
      );

      await tester.tap(
        find.text('Confirmar pagamento'),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(ConfirmacaoScreen),
        findsOneWidget,
      );
    },
  );

  // Teste 5: botão voltar retorna para a Tela 3
  testWidgets(
    'botão voltar retorna para a Tela 3',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InicioScreen(inicio: inicio),
        ),
      );

      // Abre a Tela 3
      await tester.tap(
        find.text('+ Recarregar saldo'),
      );

      await tester.pumpAndSettle();

      // Seleciona R$ 20,00
      await tester.tap(
        find.byKey(
          const ValueKey('valor_20.0'),
        ),
      );

      await tester.pump();

      // Avança para a Tela 4
      await tester.tap(
        find.text('Continuar'),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(PagamentoScreen),
        findsOneWidget,
      );

      // Volta para a Tela 3
      await tester.tap(
        find.byIcon(Icons.arrow_back),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(EscolherValorScreen),
        findsOneWidget,
      );
    },
  );
}
