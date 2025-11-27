import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/controllers/CartController.dart';
import 'package:mjbeauty/controllers/ProductController.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController> (() => CartController());
  }
}