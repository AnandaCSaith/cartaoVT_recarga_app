// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cartaovt_recarga_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Entrada recusa formulário vazio', (tester) async {
    await tester.pumpWidget(const CartaoVTRecargaApp());

    final botaoEnviar = find.text('Entrar');
    expect(botaoEnviar, findsOneWidget);

    await tester.ensureVisible(botaoEnviar);
    await tester.tap(botaoEnviar);
    await tester.pumpAndSettle();


  expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  // CORREÇÃO: Aspas corrigidas na descrição do teste
  testWidgets('Entrar a tela inicial', (tester) async {
    await tester.pumpWidget(const CartaoVTRecargaApp());
    
    // Insere os dados nos campos de texto
    await tester.enterText(find.byType(TextFormField).at(0), '0000.0000');
    await tester.enterText(find.byType(TextFormField).at(1), '0000');
    
    // Clica no botão para entrar
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    
    expect(find.text('O que você precisa hoje?'), findsOneWidget);
  });

  testWidgets('Tela de entrada segue as diretrizes de acessibilidade', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(const CartaoVTRecargaApp());

    // Validações de acessibilidade
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));

    handle.dispose();
  });
}
