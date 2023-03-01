import 'package:database_test_2/models/data_base_help.dart';
import 'package:database_test_2/models/to_do_model.dart';
import 'package:database_test_2/pages/navigation_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddProductPage extends StatefulWidget {
  int? toDoId;
  String? toDoName;
  String? toDoDesc;
  bool? update;
  AddProductPage(
      {super.key,
      required this.toDoId,
      required this.toDoName,
      required this.toDoDesc,
      required this.update});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  DataHelper? dataHelper;
  late Future<List<ToDoModel>> dataList;
  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    dataHelper = DataHelper();
    loadData();
  }

  loadData() async {
    dataHelper!.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.toDoName);
    final descriptionController = TextEditingController(text: widget.toDoDesc);
    String titlePage, buttomName;
    if (widget.update == true) {
      titlePage = "Actualizar Tarea";
      buttomName = "Actualizar";
    } else {
      titlePage = "Agregar tarea";
      buttomName = "Agregar";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nombre",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Espacio vacio";
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "nombre",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Descripción",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Espacio vacio";
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "descripción",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_fromKey.currentState!.validate()) {
                        if (widget.update == true) {
                          dataHelper!.updateProduct(
                            ToDoModel(
                                id: widget.toDoId,
                                name: nameController.text,
                                description: descriptionController.text),
                          );
                          const ScaffoldMessenger(
                            child: SnackBar(
                              content: Text("Tarea Actualizada"),
                            ),
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Navigationpage()));
                        } else {
                          dataHelper!.insertProduct(
                            ToDoModel(
                                id: null,
                                name: nameController.text,
                                description: descriptionController.text),
                          );

                          const ScaffoldMessenger(
                            child: SnackBar(
                              content: Text("Tarea Creada"),
                            ),
                          );
                        }
                      }
                      //Navigator.pop(context);
                      nameController.clear();
                      descriptionController.clear();
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          buttomName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        nameController.clear();
                        descriptionController.clear();
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 141, 141),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
