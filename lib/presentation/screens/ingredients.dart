import 'package:flutter/material.dart';
import 'package:xym/presentation/screens/ingredientsForm.dart';
import 'package:xym/presentation/screens/ingredientsEditForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  List<Map<dynamic, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchItemsFromApi();
  }

  // Método para obtener elementos de la API
  Future<void> fetchItemsFromApi() async {
    const String apiUrl = "http://54.236.91.141:3100/api/ingrediente";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          items = data
              .map((item) => {"id": item['id'], "name": item['descripcion']})
              .toList();
        });
      } else {
        print("Error al cargar los datos: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Método para agregar un nuevo elemento y enviar a la API
  Future<void> addItem(String newItem) async {
    const String apiUrl = "http://54.236.91.141:3100/api/ingrediente";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"descripcion": newItem}),
      );

      if (response.statusCode == 201) {
        setState(() {
          items.add({"id": json.decode(response.body)['id'], "name": newItem});
        });
      } else {
        print("Error al agregar el elemento: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Método para editar un elemento existente
  Future<void> editItem(int id, String updatedName) async {
    final String apiUrl = "http://54.236.91.141:3100/api/ingrediente/$id";
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({"descripcion": updatedName}),
      );

      if (response.statusCode == 200) {
        setState(() {
          int index = items.indexWhere((item) => item['id'] == id);
          if (index != -1) {
            items[index]['name'] = updatedName;
          }
        });
      } else {
        _showSnackBar('Error al editar el elemento: ${response.statusCode}.');
      }
    } catch (e) {
      _showSnackBar('Error: $e.');
    }
  }

  // Método para eliminar un elemento
  Future<void> deleteItem(int id) async {
    final String apiUrl = "http://54.236.91.141:3100/api/ingrediente/$id";
    try {
      final response = await http.delete(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          items.removeWhere((item) => item['id'] == id);
        });
      } else {
        _showSnackBar('Error al eliminar el elemento: ${response.statusCode}.');
      }
    } catch (e) {
      _showSnackBar('Error: $e.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text((index + 1).toString()), // Contador
            ),
            title: Text(items[index]['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final updatedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditItemForm(
                          itemId: items[index]['id'],
                          initialValue: items[index]['name'],
                        ),
                      ),
                    );

                    if (updatedName != null) {
                      await editItem(items[index]['id'], updatedName);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteItem(items[index]['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Abre el formulario y espera hasta que se complete
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewItemForm()),
          );

          if (newItem != null) {
            await addItem(newItem);
          }
        },
        tooltip: 'Nuevo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
