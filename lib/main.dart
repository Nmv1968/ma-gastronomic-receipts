import 'package:flutter/material.dart';
import 'package:xym/presentation/screens/home.dart';
import 'package:xym/presentation/screens/information.dart';
import 'package:xym/presentation/screens/login.dart';
import 'package:xym/service/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var db = DatabaseHelper();
  // await db.db;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    themeMode: ThemeMode.dark, // Establece el modo de tema en oscuro
    darkTheme: ThemeData.light(), // Configura el tema oscuro
    title: 'RECETAS',
    home: Builder(
      builder: (context) => LoginPage(
        onLogin: (dataAdicional) {
          print('pantalla de inicio');
          // if (dataAdicional) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InformationScreen()),
            );
          // } else {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const HomeScreen()),
          //   );
          // }
        },
        context: context,
      ),
    ),
  ));
}
