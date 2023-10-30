import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_app_demo/screen/category_detail_screen.dart';
import 'package:mobile_app_demo/services/category_service.dart';

class CategoryListItemWidget extends StatelessWidget {
  CategoryListItemWidget(
      {super.key, required this.category, required this.changeItems});
  dynamic category;
  Function changeItems;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (lala) async {
              showConfirmSoftDelete(context);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.disabled_by_default,
          ),
          SlidableAction(
            onPressed: (lala) {
              showConfirmDelete(context);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            category['name'],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            category['description'],
            style: const TextStyle(color: Colors.black54),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryDetailScreen(
                        title: "Editar Categoría",
                        isEditing: true,
                        category: category,
                      )),
            );
          },
        ),
      ),
    );
  }

  showConfirmSoftDelete(BuildContext context) {
    Widget cancelButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: const Text("Cancelar"),
      onPressed: () {
        print("Cancelando..");
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: const Text("Desactivar"),
      onPressed: () async {
        print("Eliminando..");
        await CategoryService.softDeleteById(category['id']);
        changeItems();
        Navigator.of(context).pop();
        // Otras acciones de eliminar
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Desactivar Categoría"),
      content: const Text("¿Estás seguro de desactivar la categoría?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showConfirmDelete(BuildContext context) {
    Widget cancelButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: const Text("Cancelar"),
      onPressed: () {
        print("Cancelando..");
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      child: const Text("Eliminar"),
      onPressed: () async {
        print("Eliminando..");
        await CategoryService.deleteById(category['id']);
        changeItems();
        Navigator.of(context).pop();
        // Otras acciones de eliminar
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Eliminar Categoría"),
      content: const Text("¿Estás seguro de eliminar la categoría?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
