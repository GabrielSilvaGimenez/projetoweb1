import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_shop/create_user/service/create_user_service.dart';
import 'package:web_shop/login/pages/login_page.dart';

class CreateUserController extends GetxController {
  final CreateUserService service = Get.put(CreateUserService());

  var name = ''.obs;
  var password = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> createUser() async {
    bool isValid = validateEmail(email.value);

    if (!isValid || password.value.isEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'preencha todos os campos, ou digite um email valido',
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
      return;
    }
    String result =
        await service.createUser(name.value, password.value, email.value);
    if (result != null && result.isNotEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Usuario criado com sucesso',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
        ),
      );
      Get.off(LoginPage());
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Erro durante o cadastro',
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
  }

  bool validateEmail(String email) {
    // Expressão regular para validar o formato do email
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }
}
