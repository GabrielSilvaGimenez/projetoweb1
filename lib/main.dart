import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/global_bind.dart';
import 'package:web_shop/login/pages/login_page.dart';
import 'package:web_shop/routes/pages.dart';
import 'package:web_shop/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      key: Get.key,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      getPages: Pages.routes,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.black,
        fontFamily: 'Roboto',
        // Outras configurações de estilo
      ),
      initialBinding: GlobalBind(),
    );
  }
}
