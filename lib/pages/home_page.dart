import 'package:database_test_2/models/data_base_help.dart';
import 'package:database_test_2/models/to_do_model.dart';
import 'package:database_test_2/pages/add_product_page.dart';
import 'package:database_test_2/widgets/to_do_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataHelper? dataHelper;
  late Future<List<ToDoModel>> dataList;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    dataHelper = DataHelper();
    loadData();
  }

  loadData() async {
    dataList = dataHelper!.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        // ignore: prefer_const_constructors
        title: Text("To Do List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: dataList,
              builder: (context, AsyncSnapshot<List<ToDoModel>> snapshot) {
                loadData();
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No hay tareas creadas",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      int idToDo = snapshot.data![index].id!.toInt();
                      String toDoName = snapshot.data![index].name!.toString();
                      String toDoDesc =
                          snapshot.data![index].description!.toString();
                      return ToDoItem(
                        key: ValueKey<int>(idToDo),
                        nameTask: toDoName,
                        descriptionTask: toDoDesc,
                        editTask: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AddProductPage(
                                  toDoId: idToDo,
                                  toDoName: toDoName,
                                  toDoDesc: toDoDesc,
                                  update: true),
                            ),
                          );
                        },
                        deleteTask: ((p0) {
                          setState(
                            () {
                              dataHelper!.deleteProduct(idToDo);
                              dataList = dataHelper!.getAllProducts();
                              snapshot.data!.remove(snapshot.data![index]);
                            },
                          );
                        }),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
