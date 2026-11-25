import 'package:cartaovt_recarga_app/model/passageiro_model.dart';

class InicioController {
  final PassageiroModel passageiro = PassageiroModel(
    nome: 'Ananda',
    numeroCartao: '1234.1234',
    saldo: 12.50,
    ultimaRecarga: DateTime.now(),
  );

  String formatarSaldo() {
    return 'R\$ ${passageiro.saldo.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String formatarUltimaRecarga() {
    final data = passageiro.ultimaRecarga;

    String dia = data.day.toString().padLeft(2, '0');
    String mes = data.month.toString().padLeft(2, '0');
    String ano = data.year.toString().padLeft(4, '0');
    return '$dia/$mes/$ano';
  }

  void dispose() {}
}
