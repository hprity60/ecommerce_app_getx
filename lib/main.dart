import 'package:ecommerce_app/src/controller/product_controller.dart';

import 'src/view/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductPage(),
      initialBinding: BindingsBuilder(() {
        Get.put(ProductController());
      }),
    );
  }
}
