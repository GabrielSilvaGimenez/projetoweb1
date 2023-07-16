import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/item_listing/page/item_listing_page.dart';
import 'package:web_shop/login/service/login_service.dart';
import 'package:web_shop/user/controller/user_controller.dart';

class LoginController extends GetxController {
  var login = 'Login'.obs;
  var password = ''.obs;
  var name = ''.obs;

  final LoginService service = Get.put(
    LoginService(),
  );

  @override
  onInit() {
    if (UserController.i.user.id == null) {
      UserController.i.logout();
    } else {
      // Get.to();
    }

    super.onInit();
  }

  Future<void> loginIn() async {
    try {
      String token = await service.login(
        name.value,
        password.value,
      );
      print('Token JWT: $token');
      if (token.isNotEmpty) {
        await UserController.i.save(token);
        Get.offAll(ItemListingPage());
      } else {
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'Erro ao logar',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.only(
            top: 22,
            left: 20,
            right: 20,
          ),
        );
      }
    } catch (e) {
      print('Erro durante o login: $e');
    }
  }
}
