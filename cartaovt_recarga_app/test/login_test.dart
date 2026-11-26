
import 'package:cartaovt_recarga_app/app.dart';
import 'package:cartaovt_recarga_app/view/inicio_screen.dart';
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


  expect(find.text('Campo obrigatório'), findsNWidgets(2));
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
    
    expect(find.byType(InicioScreen), findsOneWidget);
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

  testWidgets('Senha fica oculta durante a digitação', (tester) async {
  await tester.pumpWidget(const CartaoVTRecargaApp());

  final campoSenha = tester.widget<EditableText>(
    find.descendant(
      of: find.byType(TextFormField).at(1),
      matching: find.byType(EditableText),
    ),
  );

  expect(campoSenha.obscureText, isTrue);
});
}
