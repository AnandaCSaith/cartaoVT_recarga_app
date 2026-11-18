import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  static final _formatoCartao = RegExp(r'^\d{4}\.\d{4}$');
  static final _formatoSenha = RegExp(r'^\d{4}$');

  String? _cartao = "";
  String? get cartao => _cartao;
  bool get logado => _cartao != null;

  String? validarCartao(String? cartao) {
    if (cartao == null || cartao.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!_formatoCartao.hasMatch(cartao)) {
      return 'Formato inválido. Use 0000.0000';
    }
    return null;
  }

  String? validarSenha(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!_formatoSenha.hasMatch(senha)) {
      return 'Formato inválido. Use 0000';
    }
    return null;
  }

  bool entrar(String cartao, String senha) {
    if (validarCartao(cartao) != null) return false;
    if (validarSenha(senha) != null) return false;
    {
      notifyListeners();
      return true;
    }
  }

  void sair () {
    _cartao = null;
    notifyListeners();
  } 
}
