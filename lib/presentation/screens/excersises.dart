import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xym/service/user.dart';
import 'package:xym/presentation/screens/excersise.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:video_player/video_player.dart';
import '../info/generalinfo.dart';

class ExcersisesScreenScreen extends StatelessWidget {
  const ExcersisesScreenScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ExcersisesScreen();
  }
}

class ExcersisesScreen extends StatefulWidget {
  const ExcersisesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExcersisesScreen createState() => _ExcersisesScreen();
}

class _ExcersisesScreen extends State<ExcersisesScreen> {
  final UserService userService = UserService();

  dynamic objetive = '';

  Map allactivities = {};
  String activitiesforage = '';
  List<String> dias = [];
  String activity = '';
  @override
  void initState() {
    loadObjetives();
    super.initState();
  }

  loadObjetives() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      activity = prefs.getString('activity') ?? '';
      allactivities = activities;
      dias = allactivities['Rutina Ejercicios'].keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rutina de Ejercicios'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Para volver atrás
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: constraints.maxWidth /
                      700, // Ajusta el aspecto según el ancho disponible
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  // autoPlayInterval: const Duration(seconds: 3),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  // enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: dias.map((data) {
                  // List<String> desayuno = allactivities['Rutina Ejercicios']
                  //         [data]['Rutina'];
                  // List<String> almuerzo = allactivities['Rutina Ejercicios']
                  //         [data]['Ejercicios']
                  //     .toList();
                  activity = allactivities['Rutina Ejercicios'][data]['Rutina'];
                  List ejercicios = allactivities['Rutina Ejercicios'][data]
                          ['Ejercicios']
                      .toList();
                  //         [data]['Ejercicios']
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data,
                        style: const TextStyle(fontSize: 17.0),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              activity,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 10),
                            ListView(
                                shrinkWrap: true,
                                children: ejercicios.map((day) {
                                  return ListTile(
                                    title: ElevatedButton(
                                      onPressed: () async {
                                        await _onContinueExcersise(context,
                                            day['Actividad'], day['video']);
                                      },
                                      child: Text(
                                        day['Actividad'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ],
                        ),
                      )
                    ],
                  );
                }).toList());
          },
        ));
  }

  Future<void> _onContinueExcersise(
      BuildContext context, excersise, video) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ExcersiseScreenScreen(excersise: excersise, video: video)),
    );
  }

  void saveSession(String identifier, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(identifier, valor);
  }
}
