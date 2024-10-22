import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xym/service/user.dart';
import '../info/generalinfo.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Diet();
  }
}

class Diet extends StatefulWidget {
  const Diet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Diet createState() => _Diet();
}

class _Diet extends State<Diet> {
  final UserService userService = UserService();

  dynamic objetive = '';

  Map allactivities = {};
  String activitiesforage = '';
  List<String> activitiestodo = [];
  String activity = '';
  @override
  void initState() {
    loadObjetives();
    super.initState();
  }

  loadObjetives() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var agevalidation = prefs.getString('agevalidation') ?? '';
    setState(() {
      activity = prefs.getString('activity') ?? '';
      allactivities = activities;
      activitiesforage = allactivities[agevalidation];
      activitiestodo = activitiesforage.split('; ').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(activity),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Para volver atrás
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Dieta a realizar',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Actividad Física',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Deshabilitar el desplazamiento del ListView interior
                    itemCount: activitiestodo.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: 300,
                              maxHeight: 150), // Tamaño máximo del botón
                          child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                title: Text(activitiestodo[index],
                                    style: const TextStyle(fontSize: 12.0)),
                              )),
                        ),
                      );
                    },
                  )
                ],
              ),             
            ],
          ),
        ));
  }

  void saveSession(String identifier, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(identifier, valor);
  }
}
