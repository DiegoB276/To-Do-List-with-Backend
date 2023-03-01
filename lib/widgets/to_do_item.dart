import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoItem extends StatelessWidget {
  String nameTask;
  String descriptionTask;
  Function(BuildContext?) deleteTask;
  VoidCallback editTask;
  ToDoItem(
      {super.key,
      required this.nameTask,
      required this.descriptionTask,
      required this.deleteTask,
      required this.editTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.green,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nameTask,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        descriptionTask,
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: editTask,
                  icon: const Icon(Icons.edit),
                  splashRadius: 1,
                  splashColor: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
