// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xym/presentation/screens/recipe.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<Map<String, dynamic>> _recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipesFromApi(); // Cargar recetas al iniciar la pantalla
  }

  // Método para obtener recetas desde la API
  Future<void> fetchRecipesFromApi() async {
    const String apiUrl = "http://54.236.91.141:3100/api/receta";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          _recipes = data
              .map((item) => {
                    "id": item['id'],
                    "name": item['descripcion'],
                  })
              .toList();
        });
      } else {
        print("Error al cargar las recetas: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Método para eliminar una receta
  Future<void> deleteRecipe(int id) async {
    final String apiUrl = "http://54.236.91.141:3100/api/receta/$id";
    try {
      final response = await http.delete(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _recipes.removeWhere((recipe) => recipe['id'] == id);
        });
        print("Receta eliminada correctamente");
      } else {
        print("Error al eliminar la receta: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Navegar al formulario para agregar o editar una receta
  void _navigateToForm({Map<String, dynamic>? recipe}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeForm(recipe: recipe)),
    );
    fetchRecipesFromApi(); // Recargar recetas después de agregar/editar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de Recetas"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return ListTile(
                  title: Text(recipe['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(recipe: recipe),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteRecipe(recipe['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _navigateToForm(),
              child: const Text("Nueva Receta"),
            ),
          ),
        ],
      ),
    );
  }
}
