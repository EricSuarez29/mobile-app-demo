import 'package:flutter/material.dart';
import 'package:mobile_app_demo/screen/categories_screen.dart';
import 'package:mobile_app_demo/services/category_service.dart';

class CategoryDetailScreen extends StatefulWidget {
  CategoryDetailScreen({
    super.key,
    required this.title,
    this.isEditing = false,
    this.category = false,
  });
  String title;
  bool isEditing;
  dynamic category;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isEditing) {
      _nameController.text = widget.category['name'];
      _descriptionController.text = widget.category['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              //obscureText: true,
              maxLines: 8,
              //or null
              decoration: const InputDecoration.collapsed(
                hintText: "Introduzca una descripción",
              ),
            ),
            const SizedBox(height: 22.0),
            FilledButton(
              onPressed: () async {
                // Add your login logic here
                try {
                  String name = _nameController.text;
                  String description = _descriptionController.text;
                  if (widget.isEditing) {
                    await CategoryService.update(
                      category: {'name': name, 'description': description},
                      id: widget.category['id'],
                    );
                  } else {
                    await CategoryService.save(
                      name: name,
                      description: description,
                    );
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoriesScreen(
                              title: "Categorías",
                            )),
                  );
                } catch (e) {
                  print(e);
                }

                //print('Email: $email, Password: $password');
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
