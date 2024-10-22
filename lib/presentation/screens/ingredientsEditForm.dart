import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final int itemId;
  final String initialValue;

  EditItemForm({required this.itemId, required this.initialValue});

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Elemento"),
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
