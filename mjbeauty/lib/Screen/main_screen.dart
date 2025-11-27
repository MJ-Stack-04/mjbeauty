import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/Screen/CartScreen.dart';
import 'package:mjbeauty/Screen/HomeScreen.dart';
import 'package:mjbeauty/Screen/ProductScreen.dart';
import 'package:mjbeauty/controllers/main_controller.dart';

class MainScreen extends GetView<MainController>{
  const MainScreen ({super.key});


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: const[
          HomeScreen(),
          ProductScreen(),
          CartScreen(),
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
      onTap: controller.changePage,
      items: const[
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), label: 'Product'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: 'Cart'),
      ],)),
    );
  }
}