import 'package:flutter/material.dart';
import 'package:xym/presentation/screens/menu.dart';
import 'package:xym/service/user.dart';

class ObjetivesScreen extends StatefulWidget {
  const ObjetivesScreen({super.key});

  @override
  ObjetivesScreenState createState() => ObjetivesScreenState();
}

class ObjetivesScreenState extends State<ObjetivesScreen> {
  final UserService userService = UserService();
  Map<String, bool> options = {
    'Bajar de peso': false,
    'Mantener el peso': false,
    'Reforzar la Salud': false,
    'Más energia': false,
    'Claridad Mental': false,
    'Vivir más tiempo': false,
  };

  Set<String> selectedValues = {};
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
              'Cuales son tus objetivos',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            const Align(alignment: Alignment.center),
            ListView(
              shrinkWrap: true,
              children: options.keys.map((String option) {
                return CheckboxListTile(
                  title: Text(option),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: options[option],
                  onChanged: (bool? value) {
                    setState(() {
                      options[option] = value!;
                      if (value) {
                        selectedValues.add(option);
                      } else {
                        selectedValues.remove(option);
                      }
                    });
                  },
                );
              }).toList(),
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
    List success = await userService.updateObjetives(selectedValues);
    if (success.isEmpty) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const ListObjetivesScreen()),
      );
    } else {
    }
  }
}
