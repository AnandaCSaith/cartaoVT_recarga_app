import 'package:cartaovt_recarga_app/controllers/inicio_controller.dart';
import 'package:cartaovt_recarga_app/controllers/login_controller.dart';
import 'package:cartaovt_recarga_app/theme/tema.dart';
import 'package:cartaovt_recarga_app/view/login_screen.dart';
import 'package:flutter/material.dart';

class CartaoVTRecargaApp extends StatefulWidget {
  const CartaoVTRecargaApp({super.key});

  @override
  State<CartaoVTRecargaApp> createState() => _CartaoVTRecargaAppState();
}

class _CartaoVTRecargaAppState extends State<CartaoVTRecargaApp> {
  final _loginController = LoginController();
  final _inicioController = InicioController();

  @override
  void dispose() {
    _loginController.dispose();
    _inicioController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartão VT Recarga',
      debugShowCheckedModeBanner: false,
      theme: TemaCartaoVTRecargaApp.claro(),
      darkTheme: TemaCartaoVTRecargaApp.escuro(),
      home: LoginScreen(login: _loginController, inicio: _inicioController),
    );
  }
}