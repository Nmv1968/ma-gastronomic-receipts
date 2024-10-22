import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeForm extends StatefulWidget {
  final Map<String, dynamic>? recipe;
  const RecipeForm({super.key, this.recipe});

  @override
  // ignore: library_private_types_in_public_api
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipeNameController = TextEditingController();
  List<Map<String, dynamic>> _availableIngredients = [];
  List<Map<String, dynamic>> _selectedIngredients = [];
  final List<TextEditingController> _procedureControllers = [];

  @override
  void initState() {
    super.initState();
    fetchIngredientsFromApi(); // Cargar los ingredientes desde la API al iniciar
    if (widget.recipe != null) {
      // Si se está editando, cargar datos de la receta existente
      _recipeNameController.text = widget.recipe!['name'];
      _selectedIngredients =
          List<Map<String, dynamic>>.from(widget.recipe!['ingredients']);
    }
    _procedureControllers
        .add(TextEditingController()); // Primer paso del procedimiento
  }

  @override
  void dispose() {
    _recipeNameController.dispose();
    for (var controller in _procedureControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Método para obtener ingredientes de la API
  Future<void> fetchIngredientsFromApi() async {
    const String apiUrl = "http://54.236.91.141:3100/api/ingrediente";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          _availableIngredients = data
              .map((item) => {
                    "id": item['id'],
                    "description": item['descripcion'],
                  })
              .toList();
        });
      } else {
        print("Error al cargar los ingredientes: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Método para guardar la receta en la API (crear o editar)
  Future<void> saveRecipeToApi() async {
    final String apiUrl = widget.recipe == null
        ? "http://54.236.91.141:3100/api/receta"
        : "http://54.236.91.141:3100/api/receta/${widget.recipe!['id']}";
    final bool isEdit = widget.recipe != null;

    final String recipeName = _recipeNameController.text;
    final List<Map<String, dynamic>> ingredients =
        _selectedIngredients.map((ingredient) {
      return {
        "id_ingrediente": ingredient['id'],
        "descripcion": ingredient['description'],
        "cantidad": double.tryParse(ingredient['quantity'].text) ?? 0,
      };
    }).toList();
    final List<dynamic> procedures = _procedureControllers
        .map((controller) => {"descripcion": controller.text})
        .toList();

    final Map<String, dynamic> requestBody = {
      "descripcion": recipeName,
      "ingredientes": ingredients,
      "procedimientos": procedures,
    };

    print(requestBody);
    try {
      final response = isEdit
          ? await http.put(Uri.parse(apiUrl),
              body: json.encode(requestBody),
              headers: {"Content-Type": "application/json"})
          : await http.post(Uri.parse(apiUrl),
              body: json.encode(requestBody),
              headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Receta guardada correctamente");
        // ignore: use_build_context_synchronously
        Navigator.pop(context); // Volver al listado de recetas
      } else {
        print(response.body);
        print("Error al guardar la receta: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe != null ? "Editar Receta" : "Nueva Receta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _recipeNameController,
                decoration:
                    const InputDecoration(labelText: "Nombre de la Receta"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre para la receta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text("Seleccionar Ingredientes y Cantidades",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ..._selectedIngredients.map((ingredient) {
                return Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: ingredient['id'],
                        items: _availableIngredients.map((ingredient) {
                          return DropdownMenuItem(
                            value: ingredient['id'],
                            child: Text(ingredient['description']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            ingredient['id'] = value;
                            ingredient['description'] =
                                _availableIngredients.firstWhere((element) =>
                                    element['id'] == value)['description'];
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Selecciona un ingrediente';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: "Ingrediente"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller:
                            ingredient['quantity'] ?? TextEditingController(),
                        decoration:
                            const InputDecoration(labelText: "Cantidad"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa una cantidad';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                );
              }),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedIngredients
                        .add({"id": null, "quantity": TextEditingController()});
                  });
                },
                child: const Text("Agregar Ingrediente"),
              ),
              const SizedBox(height: 20),
              const Text("Procedimientos",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ..._procedureControllers.map((controller) {
                return TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                      labelText: "Paso del procedimiento"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un paso del procedimiento';
                    }
                    return null;
                  },
                );
              }),
              TextButton(
                onPressed: () {
                  setState(() {
                    _procedureControllers.add(TextEditingController());
                  });
                },
                child: const Text("Agregar Paso"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveRecipeToApi();
                  }
                },
                child: const Text("Guardar Receta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
