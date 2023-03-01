import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  TextEditingController nameController;
  TextEditingController descriptionController;
  VoidCallback saveTask;
  VoidCallback cancelTask;
  DialogBox(
      {super.key,
      required this.nameController,
      required this.descriptionController,
      required this.saveTask,
      required this.cancelTask});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green.shade100,
      content: SizedBox(
        height: 400,
        child: Column(
          children: [
            const Text("Nombre"),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Nombre"),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Descripción"),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Descripción"),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  color: Colors.green.shade300,
                  onPressed: cancelTask,
                  child: const Text("Cancelar"),
                ),
                MaterialButton(
                  color: Colors.green.shade300,
                  onPressed: saveTask,
                  child: const Text("Agregar"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
