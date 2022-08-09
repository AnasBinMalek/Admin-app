import 'package:admin_app/screen/nav_bar/category.dart';
import 'package:admin_app/screen/nav_bar/home_page.dart';
import 'package:admin_app/screen/nav_bar/order.dart';
import 'package:admin_app/screen/nav_bar/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [HomePage(), CategoryPage(), ProductPage(), OrderPage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                //  size: currentIndex == 0 ? 30 : 10,
              ),
              label: "Home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Category",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: "Product",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.online_prediction_rounded),
              label: "Order",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
