import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xym/presentation/screens/ingredients.dart';
import 'package:xym/presentation/screens/recipeList.dart';
import 'package:xym/service/user.dart';
// import '../info/generalinfo.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Information();
  }
}

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Information createState() => _Information();
}

class _Information extends State<Information> {
  final UserService userService = UserService();
  String name = '';
  String gender = '';
  int height = 0;
  int age = 0;
  int weight = 0;
  String users = '';
  String sesion = '';
  @override
  void initState() {
    loadObjetives();
    super.initState();
  }

  loadObjetives() async {
    var listUser = await userService.getUserInfo();
    setState(() {
      name = listUser[0]['name'] ?? '';
      gender = listUser[0]['gender'] ?? '';
      height = listUser[0]['height'] ?? '';
      age = listUser[0]['age'] ?? '';
      weight = listUser[0]['weight'] ?? '';
      // users = listUser.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido/a $name'),
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
              // Text(activitieslist1.toString()),
              // Text(users),
              // Text(sesion),
              const SizedBox(height: 10),
              const Text(
                'Menú de opciones',
                style: TextStyle(fontSize: 16),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: 300,
                          maxHeight: 150), // Tamaño máximo del botón
                      child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: const AssetImage('assets/8.jpg'),
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () async {
                                await _onContinueIngrediente(
                                    context, 'Ingredientes');
                              },
                              child: const Stack(
                                children: [
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: Text(
                                      'Ingredientes',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: 300,
                          maxHeight: 150), // Tamaño máximo del botón
                      child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: const AssetImage('assets/7.jpg'),
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () async {
                                await _onContinueReceta(context, 'Recetas');
                              },
                              child: const Stack(
                                children: [
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: Text(
                                      'Recetas',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _onContinueIngrediente(
      BuildContext context, activity) async {
    saveSession('activity', activity);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IngredientsPage()),
    );
  }

  Future<void> _onContinueReceta(BuildContext context, activity) async {
    saveSession('activity', activity);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecipeList()),
    );
  }
  
  void saveSession(String identifier, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(identifier, valor);
  }
}
