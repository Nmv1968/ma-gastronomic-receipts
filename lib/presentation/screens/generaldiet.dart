import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xym/service/user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../info/generalinfo.dart';

class GeneralDietScreenScreen extends StatelessWidget {
  const GeneralDietScreenScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GeneralDietScreen();
  }
}

class GeneralDietScreen extends StatefulWidget {
  const GeneralDietScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GeneralDietScreen createState() => _GeneralDietScreen();
}

class _GeneralDietScreen extends State<GeneralDietScreen> {
  final UserService userService = UserService();

  dynamic objetive = '';

  Map allactivities = {};
  String activitiesforage = '';
  List<String> dieta = [];
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
      dieta = allactivities['dieta general'].keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dieta general'),
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
                items: dieta.map((data) {
                  List<String> desayuno = allactivities['dieta general'][data]
                          ['desayuno']
                      .split('; ')
                      .toList();
                  List<String> almuerzo = allactivities['dieta general'][data]
                          ['almuerzo']
                      .split('; ')
                      .toList();
                  List<String> cena = allactivities['dieta general'][data]
                          ['cena']
                      .split('; ')
                      .toList();
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
                            const Text(
                              'Desayuno',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 10),
                            ListView(
                                shrinkWrap: true,
                                children: desayuno.map((String activity) {
                                  return ListTile(
                                    title: Text(activity,
                                        style: const TextStyle(fontSize: 11.0)),
                                  );
                                }).toList()),
                            const Text(
                              'Almuerzo',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            ListView(
                                shrinkWrap: true,
                                children: almuerzo.map((String activity) {
                                  return ListTile(
                                    title: Text(activity,
                                        style: const TextStyle(fontSize: 11.0)),
                                  );
                                }).toList()),
                            const Text(
                              'Cena',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            ListView(
                                shrinkWrap: true,
                                children: cena.map((String activity) {
                                  return ListTile(
                                    title: Text(activity,
                                        style: const TextStyle(fontSize: 11.0)),
                                  );
                                }).toList())
                          ],
                        ),
                      )
                    ],
                  );
                }).toList()
                // images.map((image) {
                //   return Builder(
                //     builder: (BuildContext context) {
                //       return Container(
                //         width: MediaQuery.of(context).size.width,
                //         margin: const EdgeInsets.symmetric(horizontal: 5.0),
                //         decoration: const BoxDecoration(
                //           color: Colors.grey,
                //         ),
                //         child: Image.network(
                //           image,
                //           fit: BoxFit.cover,
                //         ),
                //       );
                //     },
                //   );
                // }).toList(),

                );
          },

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     const Text(
          //       'Dieta día 1',
          //       style: TextStyle(fontSize: 20.0),
          //     ),
          //     const SizedBox(height: 10),
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           const Text(
          //             'Desayuno',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           const SizedBox(height: 10),
          //           ListView(
          //               shrinkWrap: true,
          //               children: desayuno.map((String activity) {
          //                 return ListTile(
          //                   title: Text(activity,
          //                       style: const TextStyle(fontSize: 12.0)),
          //                 );
          //               }).toList()),
          //           const Text(
          //             'Almuerzo',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           ListView(
          //               shrinkWrap: true,
          //               children: almuerzo.map((String activity) {
          //                 return ListTile(
          //                   title: Text(activity,
          //                       style: const TextStyle(fontSize: 12.0)),
          //                 );
          //               }).toList()),
          //           const Text(
          //             'Cena',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //           ListView(
          //               shrinkWrap: true,
          //               children: cena.map((String activity) {
          //                 return ListTile(
          //                   title: Text(activity,
          //                       style: const TextStyle(fontSize: 12.0)),
          //                 );
          //               }).toList()),
          //           ElevatedButton(
          //             onPressed: () async {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => const DietDay2Screen()),
          //               );
          //             },
          //             child: const Text('Continuar'),
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
        ));
  }

  void saveSession(String identifier, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(identifier, valor);
  }
}
