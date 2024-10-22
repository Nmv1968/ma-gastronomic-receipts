import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:xym/presentation/screens/information.dart';
import 'package:xym/service/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Home();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  UserService userService = UserService();
  String genderController = 'Masculino';
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> opciones = ['Masculino', 'Femenino'];
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
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Antes de continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Cuéntame más de ti',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            DropdownButton<String>(
                              // Valor predeterminado
                              value: genderController,
                              // Lista de elementos desplegables
                              items: opciones.map((String opcion) {
                                return DropdownMenuItem<String>(
                                  value: opcion,
                                  child: Text(opcion),
                                );
                              }).toList(),
                              // Acción cuando se selecciona un elemento
                              onChanged: (nuevoValor) {
                                setState(() {
                                  genderController = nuevoValor!;
                                });
                              },
                            ),
                            TextFormField(
                              controller: heightController,
                              decoration:
                                  const InputDecoration(labelText: 'Estatura'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: ageController,
                              decoration:
                                  const InputDecoration(labelText: 'Edad'),
                            ),
                            TextFormField(
                              controller: weightController,
                              decoration:
                                  const InputDecoration(labelText: 'Peso'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      await _onContinue(context);
                    },
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _onContinue(BuildContext context) async {
    String gender = genderController;
    String height = heightController.text;
    String age = ageController.text;
    String weight = weightController.text;

    List success = await userService.update(gender, height, age, weight);
    if (success.isEmpty) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Information()),
      );
    } else {
      _showSnackBar('Error al actualizar. Por favor, verifica los datos.');
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
