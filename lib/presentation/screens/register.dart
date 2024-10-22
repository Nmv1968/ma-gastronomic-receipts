import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:xym/service/user.dart';

class RegisterScreen extends StatelessWidget {
  final UserService userService = UserService();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final Function() onLogin;
  // final BuildContext context;

  RegisterScreen(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Para volver atrás
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Registrate',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: fullnameController,
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _onContinue(context);
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onContinue(BuildContext context) async {
    String fullname = fullnameController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    int success = await userService.insert(fullname, username, password);
    if (success > 0) {      
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      _showSnackBar(
          'Error al registrar. Por favor, verifica los datos.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
