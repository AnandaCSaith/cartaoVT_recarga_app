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
  final loginController = LoginController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartão VT Recarga',
      debugShowCheckedModeBanner: false,
      theme: TemaCartaoVTRecargaApp.claro(),
      darkTheme: TemaCartaoVTRecargaApp.escuro(),
      home: LoginScreen(login: loginController),
    );
  }
}
