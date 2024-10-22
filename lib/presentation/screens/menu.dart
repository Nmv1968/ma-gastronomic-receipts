import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xym/presentation/screens/information.dart';
import 'package:xym/service/user.dart';

class ListObjetivesScreen extends StatelessWidget {
  const ListObjetivesScreen({super.key});

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
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.add),
        //   onPressed: () {
        //     Navigator.pushNamed(context, "/editar",
        //         arguments: (id: 0, nombre: "", especie: ""));
        //   },
        // ),
        body: const Objetives());
  }
}

class Objetives extends StatefulWidget {
  const Objetives({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Objetives createState() => _Objetives();
}

class _Objetives extends State<Objetives> {
  final UserService userService = UserService();

  List<String> objetiveslist = [];
  @override
  void initState() {
    loadObjetives();
    super.initState();
  }

  loadObjetives() async {
    List auxObjetives = await userService.getUserInfo();
    setState(() {
      objetiveslist = auxObjetives[0]['objetives'].split(', ').toList();
      saveSession('gender', auxObjetives[0]['gender']);
      saveSession('height', auxObjetives[0]['height'].toString());
      saveSession('age', auxObjetives[0]['age'].toString());
      saveSession('weight', auxObjetives[0]['weight'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Selecciona una opción',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            children: objetiveslist.map((String objetive) {
              return ElevatedButton(
                onPressed: () async {
                  await _onContinue(context, objetive);
                },
                child: Text(objetive),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _onContinue(BuildContext context, objetive) async {
    // if (objetive == 'Bajar de peso') {}
    // if (objetive == 'Mantener el peso') {}
    // if (objetive == 'Reforzar la Salud') {}
    // if (objetive == 'Más energia') {}
    // if (objetive == 'Claridad Mental') {}
    // if (objetive == 'Vivir más tiempo') {}
    saveSession('objetive', objetive);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InformationScreen()),
    );
  }

  getUserInfo() async {
    List userInfo = await userService.getUserInfo();
    return userInfo[0];
  }

  void saveSession(String identifier, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(identifier, valor);
  }
}
