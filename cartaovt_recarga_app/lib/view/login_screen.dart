import 'package:cartaovt_recarga_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.login});

  final LoginController login;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cartaoController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _senhaEscondida = true;

  void _entrar() {
    if (!_formKey.currentState!.validate()) return;
    if (!widget.login.entrar(_cartaoController.text, _senhaController.text)) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen(login: widget.login)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.airport_shuttle,
                    size: 100.0,
                    color: cores.primary,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'CartãoVT Recarga',
                    textAlign: TextAlign.center,
                    style: textos.headlineLarge?.copyWith(color: cores.primary),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Consulte o saldo e recarregue seu cartão de vale-transporte.',
                    textAlign: TextAlign.center,
                    style: textos.bodyLarge,
                  ),
                  SizedBox(height: 32.0),

                  TextFormField(
                    controller: _cartaoController,
                    decoration: InputDecoration(
                      labelText: 'Cartão',
                      hintText: '0000.0000',
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: widget.login.validarCartao,
                  ),
                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: '0000',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _senhaEscondida
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _senhaEscondida = !_senhaEscondida;
                          });
                        },
                      ),
                    ),
                    obscureText: _senhaEscondida,
                    keyboardType: TextInputType.number,
                    validator: widget.login.validarSenha,
                  ),
                  const SizedBox(height: 32.0),
                  FilledButton(
                    onPressed: _entrar,
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
