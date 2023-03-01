import 'package:database_test_2/pages/add_product_page.dart';
import 'package:database_test_2/pages/home_page.dart';
import 'package:flutter/material.dart';

class Navigationpage extends StatefulWidget {
  const Navigationpage({super.key});

  @override
  State<Navigationpage> createState() => _NavigationpageState();
}

class _NavigationpageState extends State<Navigationpage> {
  int count = 0;
  List<Widget> listPages = [
    const HomePage(),
    AddProductPage(toDoId: null, toDoName: null, toDoDesc: null, update: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            count = value;
          });
        },
        selectedItemColor: Colors.green,
        currentIndex: count,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: "Añadir",
          )
        ],
      ),
      body: listPages[count],
    );
  }
}
