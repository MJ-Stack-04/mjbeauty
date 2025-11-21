import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/routes/AppPages.dart';
import 'package:mjbeauty/routes/AppRoutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Approutes.home,
      getPages: AppPages.pages,
      title: 'MJ Beauty',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
