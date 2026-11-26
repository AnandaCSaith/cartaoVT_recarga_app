
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cartaovt_recarga_app/model/pagamento_model.dart';
import 'package:cartaovt_recarga_app/view/pagamento_screen.dart';
import 'package:cartaovt_recarga_app/view/escolher_valor_screen.dart';
import 'package:cartaovt_recarga_app/view/confirmacao_screen.dart';

void main() {
  // Teste 1: valor da recarga é exibido corretamente
  testWidgets(
    'valor da recarga é exibido corretamente',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PagamentoScreen(valorRecarga: 20.00),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is RichText &&
              widget.text.toPlainText() ==
                  'Valor da recarga: R\$ 20,00',
        ),
        findsOneWidget,
      );
    },
  );

  // Teste 2: três formas de pagamento são exibidas
  testWidgets(
    'três formas de pagamento são exibidas',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PagamentoScreen(valorRecarga: 20.00),
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
        const MaterialApp(
          home: PagamentoScreen(valorRecarga: 20.00),
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

      // Deve continuar existindo apenas uma opção selecionada
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
        const MaterialApp(
          home: PagamentoScreen(valorRecarga: 20.00),
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
        const MaterialApp(
          home: EscolherValorScreen(),
        ),
      );

      // Seleciona R$ 20,00 na Tela 3
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
