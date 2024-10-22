import 'package:flutter/material.dart';

class NewItemForm extends StatefulWidget {
  @override
  _NewItemFormState createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Elemento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: "Nombre del Elemento"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Envía el nuevo elemento a la pantalla principal
                    Navigator.pop(context, _controller.text);
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
