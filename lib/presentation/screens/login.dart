import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xym/presentation/screens/register.dart';
import 'package:xym/service/auth.dart';
import 'package:xym/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final AuthService authService = AuthService();
  final ApiService apiService = ApiService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Function(bool) onLogin;
  final BuildContext context;

  LoginPage({super.key, required this.onLogin, required this.context});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RECETAS'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Inicia sesión para continuar'),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _signIn(context);
                },
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _register(context);
                },
                child: const Text('Registrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    dynamic login = await apiService.login(username, password);
    print(login.statusCode);
    dynamic loginData = json.decode(login.body);
    if (login.statusCode != 201) {
      _showSnackBar(loginData['message']);
    } else {
      if (loginData['success']) {
        // var resultLogin = true;
        // saveSession('id', resultLogin.data['id'].toString());
        // saveSession('name', resultLogin.data['full_name']);
        var dataAdicional = true;
        onLogin(dataAdicional); // Callback to handle navigation
      } else {
        _showSnackBar(loginData['message']);
      }
    }
  }

  Future<void> _register(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen(context)),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void saveSession(String identifier, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(identifier, valor);
  }
}
